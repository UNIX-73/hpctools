import os
import re

script_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.realpath(os.path.join(script_dir, ".."))  # normaliza ../

src_dir = os.path.join(root_dir, "src")
src_vec_dir = os.path.join(root_dir, "src_vec")
src_vec_manual_dir = os.path.join(root_dir, "src_vec_manual")

build_dir = os.path.join(root_dir, "build")
vec_build_dir = os.path.join(root_dir, "vec_build")
vec_manual_build_dir = os.path.join(root_dir, "vec_manual_build")


compilers = {
    "gcc_8_4_0": "gcc-8.4.0",
    "gcc_10_1_0": "gcc-10.1.0",
    "gcc_11_4_0": "gcc",
}
task3_compilers = {
    "icc": "icc",
    "icx": "icx",
    "clang": "clang",
}


modules = {
    "gcc_8_4_0": "module load cesga/2020",
    "gcc_10_1_0": "module load cesga/2020",
    "gcc_11_4_0": "module load cesga/2025",
    "icc": "module load cesga/2022 intel/2023.2.1 openblas imkl",
    "icx": "module load intel/2024.2.1 openblas imkl",
}

no_vector_flags = "-fno-tree-vectorize -fno-tree-slp-vectorize"
vector_flags = "-march=native -ftree-vectorize -ftree-slp-vectorize"
vector_info_flags = "-fopt-info-vec -fopt-info-vec-missed"
optimization_flags = {
    "O0": f"-O0 {no_vector_flags}",
    "O1": f"-O1 {no_vector_flags}",
    "O2": f"-O2 {no_vector_flags}",
    "O3": f"-O3 {vector_flags} {vector_info_flags}",
    "Ofast": f"-Ofast {vector_flags} {vector_info_flags}",
}

clangd_no_vector_flags = "-fno-vectorize -fno-slp-vectorize"
clangd_vector_flags = "-march=native -fvectorize -fslp-vectorize"
clangd_vector_info_flags = (
    "-Rpass=loop-vectorize "
    "-Rpass-missed=loop-vectorize "
    "-Rpass-analysis=loop-vectorize"
)
clangd_optimization_flags = {
    "O0": f"-O0 {clangd_no_vector_flags}",
    "O1": f"-O1 {clangd_no_vector_flags}",
    "O2": f"-O2 {clangd_no_vector_flags}",
    "O3": f"-O3 {clangd_vector_flags} {clangd_vector_info_flags}",
    "Ofast": f"-Ofast {clangd_vector_flags} {clangd_vector_info_flags}",
}


row_swapping = {
    "": "",
    "rs": "-DROW_SWAPPING",
}

time_regex = re.compile(r"Time taken by ([\w\s]+): (\d+) ms")
