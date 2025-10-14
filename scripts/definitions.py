import os
import re

script_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.realpath(os.path.join(script_dir, ".."))  # normaliza ../
build_dir = os.path.join(root_dir, "build")

compilers = {
    "gcc_8_4_0": "gcc-8.4.0",
    "gcc_10_1_0": "gcc-10.1.0",
    "gcc_11_4_0": "gcc",
}

modules = {
    "gcc_8_4_0": "module load cesga/2020",
    "gcc_10_1_0": "module load cesga/2020",
    "gcc_11_4_0": "module load cesga/2025",
}

vector_flags = "-march=native -fno-tree-vectorize -ftree-slp-vectorize"
vector_info_flags = "-fopt-info-vec -fopt-info-vec-missed -fopt-info-vec-all"
optimization_flags = {
    "O0": "-O0",
    "O1": "-O1",
    "O2": "-O2 ",
    "O3": f"-O3 {vector_flags} {vector_info_flags}",
    "Ofast": f"-Ofast {vector_flags} {vector_info_flags}",
}

row_swapping = {
    "": "",
    "rs": "-DROW_SWAPPING",
}

time_regex = re.compile(r"Time taken by ([\w\s]+): (\d+) ms")
