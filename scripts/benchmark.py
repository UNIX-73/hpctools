import os
import re
import json
import subprocess
import definitions as defs
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

MAX_CORES = 32
job_start_t = time.time()
matrix_sizes = ["1024", "2048", "4096"]
results = {}

time_regex = re.compile(r"Time taken by ([\w\s]+): (\d+) ms")


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

    times = time_regex.findall(result.stdout)
    if not times:
        return {
            "matrix_size": m_size,
            "iteration": iteration,
            "times": None,
            "stdout": result.stdout,
        }

    entry = {
        "matrix_size": m_size,
        "iteration": iteration,
        "times": {name.strip(): int(ms) for name, ms in times},
    }
    iter_end_t = time.time()
    iter_time = iter_end_t - iter_start
    total_job_time = iter_end_t - job_start_t

    print(
        f"--> COMPLETED {compiler_tag}/{o_tag}/{exe_name} size {m_size} iter {iteration}: {entry['times']} | "
        f"iter {iter_time:.2f}s | total {total_job_time/60:.2f}min",
        flush=True,
    )
    return (compiler_tag, o_tag, exe_name, m_size, entry)


tasks = []
with ThreadPoolExecutor(max_workers=MAX_CORES) as executor:
    for compiler_tag in defs.compilers.keys():
        for o_tag in defs.optimization_flags.keys():
            for rs_tag in defs.row_swapping.keys():

                exe_name = f"dgesv{('_' + rs_tag) if rs_tag else ''}"
                exe_path = os.path.join(defs.build_dir, compiler_tag, o_tag, exe_name)
                if not os.path.exists(exe_path):
                    print(f"Binary not found: {exe_path}")
                    continue

                for m_size in matrix_sizes:
                    for i in range(5):
                        future = executor.submit(
                            run_benchmark,
                            exe_path,
                            compiler_tag,
                            o_tag,
                            exe_name,
                            m_size,
                            i + 1,
                        )
                        tasks.append(future)

    for future in as_completed(tasks):
        result = future.result()
        if result is None:
            continue
        compiler_tag, o_tag, exe_name, m_size, entry = result
        results.setdefault(compiler_tag, {}).setdefault(o_tag, {}).setdefault(
            exe_name, {}
        ).setdefault(m_size, []).append(entry)

# save results
output_path = os.path.join(defs.build_dir, "benchmark_results.json")
with open(output_path, "w") as f:
    json.dump(results, f, indent=4)

print(f":) Results saved to {output_path}")
