import os
import re
import json
import subprocess
import definitions as defs

matrix_sizes = ["1024", "2048", "4096"]
results = {}

time_regex = re.compile(r"Time taken by ([\w\s]+): (\d+) ms")

for compiler_tag in defs.compilers.keys():
    for o_tag in defs.optimization_flags.keys():
        for rs_tag in defs.row_swapping.keys():

            exe_name = f"dgesv{('_' + rs_tag) if rs_tag else ''}"
            exe_path = os.path.join(defs.build_dir, compiler_tag, o_tag, exe_name)

            if not os.path.exists(exe_path):
                print(f"Binary not found: {exe_path}")
                continue

            bin_results = []

            for m_size in matrix_sizes:
                for i in range(5):
                    print(f"▶️ Running [{exe_name}] - Size {m_size} - Iter {i + 1}/5")
                    result = subprocess.run(
                        [exe_path, m_size],
                        check=True,
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        text=True,
                    )

                    times = time_regex.findall(result.stdout)
                    if times:
                        entry = {
                            "matrix_size": m_size,
                            "iteration": i + 1,
                            "times": {name.strip(): int(ms) for name, ms in times},
                        }
                        bin_results.append(entry)
                    else:
                        print("No timing info found in output:")
                        print(result.stdout)

            results.setdefault(compiler_tag, {}).setdefault(o_tag, {})[
                exe_name
            ] = bin_results

output_path = os.path.join(defs.build_dir, "benchmark_results.json")
with open(output_path, "w") as f:
    json.dump(results, f, indent=4)

print(f"✅ Results saved to {output_path}")
