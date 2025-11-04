import json
import definitions as defs
import pprint
import statistics
from tabulate import tabulate

INPUT = "./results/raw/benchmark_results_1c1.json"
OUTPUT = "./results/benchmark_summary_1c1.json"

matrix_sizes = ["1024", "2048", "4096"]

results = {}
with open(INPUT, "r") as f:
    data = json.load(f)

    for compiler in defs.compilers.keys():
        results[compiler] = {}
        for optimization in defs.optimization_flags.keys():
            results[compiler][optimization] = {}
            for m_size in matrix_sizes:
                results[compiler][optimization][m_size] = {}

                dgesv_times = []
                my_dgesv_times = []

                for iter in range(5):
                    times = data[compiler][optimization]["dgesv_rs"][m_size][iter][
                        "times"
                    ]

                    dgesv_times.append(times["Lapacke dgesv"])
                    my_dgesv_times.append(times["my dgesv solver"])

                res = round(statistics.median(dgesv_times) / 1000, 3)
                results[compiler][optimization][m_size]["dgesv"] = res

                res = round(statistics.median(my_dgesv_times) / 1000, 3)
                results[compiler][optimization][m_size]["my_dgesv"] = res

pprint.pprint(results)
with open(OUTPUT, "w") as outfile:
    json.dump(results, outfile, indent=4)
