from tabulate import tabulate
import definitions as defs
import os.path as path
import json
from statistics import mean

JSON_SUMMARY = "benchmark_summary_1c_task3.json"
JSON_PATH = path.join(defs.root_dir, "results/")
COLUMNS = list(defs.optimization_flags.keys())
MATRIX_SIZES = ["1024", "2048", "4096"]

with open(f"{JSON_PATH}/{JSON_SUMMARY}", "r") as f:
    data = json.load(f)

for compiler, compiler_data in data.items():
    print(f"\n=== {compiler} ===")

    table = []
    headers = ["Matrix Size"] + COLUMNS + ["Ref"]

    for size in MATRIX_SIZES:
        row = [f"{size}×{size}"]
        ref_values = []

        for opt in COLUMNS:
            if opt in compiler_data and size in compiler_data[opt]:
                val = compiler_data[opt][size]["my_dgesv"]
                row.append(f"{val:.3f}")
                ref_values.append(compiler_data[opt][size]["dgesv"])
            else:
                row.append("-")

        row.append(f"{mean(ref_values):.3f}" if ref_values else "-")
        table.append(row)

    print(tabulate(table, headers=headers, tablefmt="github"))
