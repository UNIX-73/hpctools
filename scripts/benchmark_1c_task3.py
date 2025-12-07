"""
This script does the same as benchmark_64.py but with single threaded execution so it
takes a lot longer to test the results but with the expectation to get more trustworthy results
"""

import os
import json
import subprocess
import definitions as defs
import time

job_start_t = time.time()
matrix_sizes = ["1024", "2048", "4096"]
results = {}


def run_benchmark(exe_path, compiler_tag, o_tag, exe_name, m_size, iteration):
    iter_start = time.time()
    print(
        f"--> RUNNING [{os.path.join(compiler_tag, o_tag, exe_name)}] - Size {m_size} - Iter {iteration}/5",
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
        f"--> COMPLETED {compiler_tag}/{o_tag}/{exe_name} size {m_size} iter {iteration}: "
        f"{entry['times']} | iter {iter_time:.2f}s | total {total_job_time/60:.2f}min"
    )
    return compiler_tag, o_tag, exe_name, m_size, entry


compilers = defs.task3_compilers | defs.compilers

for compiler_tag in compilers.keys():
    for o_tag in defs.optimization_flags.keys():

        exe_name = "dgesv"
        exe_path = os.path.join(defs.vec_build_dir, compiler_tag, o_tag, exe_name)

        if not os.path.exists(exe_path):
            print(f"Binary not found: {exe_path}")
            continue

        for m_size in matrix_sizes:
            for i in range(5):
                result = run_benchmark(
                    exe_path, compiler_tag, o_tag, exe_name, m_size, i + 1
                )
                compiler_tag, o_tag, exe_name, m_size, entry = result
                results.setdefault(compiler_tag, {}).setdefault(o_tag, {}).setdefault(
                    exe_name, {}
                ).setdefault(m_size, []).append(entry)


output_path = os.path.join(defs.vec_build_dir, "benchmark_results_1c.json")
with open(output_path, "w") as f:
    json.dump(results, f, indent=4)

print(f":) Results saved to {output_path}")
