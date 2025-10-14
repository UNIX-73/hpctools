import os
import json
import subprocess
import definitions as defs
import time


"""
Script made to test time variations in a single binary

This script was made because some variations have been seen in the benchmark.py execution with 64 threads
so the idea is to confirm that this time variation still occurs in single threaded execution

This is the results that I got from the 64 core benchmark in gcc-8.4.0-O2-2048-dgesv_rs

"2048": [
            {
                "matrix_size": "2048",
                "iteration": 3,
                "times": {
                    "Lapacke dgesv": 5637,
                    "my dgesv solver": 50175
                }
            },
            {
                "matrix_size": "2048",
                "iteration": 5,
                "times": {
                    "Lapacke dgesv": 6340,
                    "my dgesv solver": 81268
                }
            },
            {
                "matrix_size": "2048",
                "iteration": 2,
                "times": {
                    "Lapacke dgesv": 6853,
                    "my dgesv solver": 160546
                }
            },
            {
                "matrix_size": "2048",
                "iteration": 4,
                "times": {
                    "Lapacke dgesv": 7677,
                    "my dgesv solver": 164023
                }
            },
            {
                "matrix_size": "2048",
                "iteration": 1,
                "times": {
                    "Lapacke dgesv": 5996,
                    "my dgesv solver": 210473
                }
            }
        ],
"""

m_size = "2048"
compiler = "gcc_8_4_0"
opt = "O2"
exe_name = "dgesv_rs"
iterations = 20


start_time = time.time()

exe_path = os.path.join(defs.build_dir, compiler, opt, exe_name)
if not os.path.exists(exe_path):
    raise FileNotFoundError(f"Binary not found: {exe_path}")

results = {}


for i in range(1, iterations + 1):
    print(f"--> Iteration {i}/{iterations}", flush=True)
    result = subprocess.run(
        [exe_path, m_size],
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )

    times = defs.time_regex.findall(result.stdout)
    if not times:
        print("No timing info found")
        entry = {
            "matrix_size": m_size,
            "iteration": i,
            "times": None,
            "stdout": result.stdout.strip(),
        }
    else:
        entry = {
            "matrix_size": m_size,
            "iteration": i,
            "times": {name.strip(): int(ms) for name, ms in times},
        }

    results[str(i)] = entry
    print(f"Iteration[{i}] took { time.time() - start_time }s")

output_path = os.path.join(defs.build_dir, "benchmark_results_variation.json")
with open(output_path, "w") as f:
    json.dump(results, f, indent=4)

print(f"\nResults saved to {output_path}")
