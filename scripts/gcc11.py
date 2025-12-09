"""
This script does the same as benchmark_64.py but with single threaded execution so it
takes a lot longer to test the results but with the expectation to get more trustworthy results
It only benchmarsk one compiler
"""

import os
import json
import subprocess
import definitions as defs
import time

COMPILER = "gcc_11_4_0"
MATRIX_SIZES = ["1024", "2048", "4096"]
BUILD_DIR = defs.vec_build_dir


job_start_t = time.time()
results = {}


def run_benchmark(exe_path, COMPILER, o_tag, exe_name, m_size, iteration):
    iter_start = time.time()
    print(
        f"--> RUNNING [{os.path.join(COMPILER, o_tag, exe_name)}] - Size {m_size} - Iter {iteration}/5",
        flush=True,
    )

    result = subprocess.run(
        [exe_path, m_size],
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )

    times = defs.time_regex.findall(result.stdout)
    if not times:
        entry = {
            "matrix_size": m_size,
            "iteration": iteration,
            "times": None,
            "stdout": result.stdout,
        }
    else:
        entry = {
            "matrix_size": m_size,
            "iteration": iteration,
            "times": {name.strip(): int(ms) for name, ms in times},
        }

    iter_end_t = time.time()
    iter_time = iter_end_t - iter_start
    total_job_time = iter_end_t - job_start_t

    print(
        f"--> COMPLETED {COMPILER}/{o_tag}/{exe_name} size {m_size} iter {iteration}: "
        f"{entry['times']} | iter {iter_time:.2f}s | total {total_job_time/60:.2f}min"
    )
    return COMPILER, o_tag, exe_name, m_size, entry


for o_tag in defs.optimization_flags.keys():

    exe_name = "dgesv"
    exe_path = os.path.join(BUILD_DIR, COMPILER, o_tag, exe_name)

    if not os.path.exists(exe_path):
        print(f"Binary not found: {exe_path}")
        continue

    for m_size in MATRIX_SIZES:
        for i in range(5):
            result = run_benchmark(exe_path, COMPILER, o_tag, exe_name, m_size, i + 1)
            COMPILER, o_tag, exe_name, m_size, entry = result
            results.setdefault(COMPILER, {}).setdefault(o_tag, {}).setdefault(
                exe_name, {}
            ).setdefault(m_size, []).append(entry)


output_path = os.path.join(BUILD_DIR, f"benchmark_results_{COMPILER}.json")
with open(output_path, "w") as f:
    json.dump(results, f, indent=4)

print(f":) Results saved to {output_path}")
