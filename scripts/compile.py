import os
import subprocess

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

optimization_flags = {
    "O0": "-O0",
    "O1": "-O1",
    "O2": "-O2",
    "O3": "-O3",
    "Ofast": "-Ofast",
}

row_swapping = {
    "": "",
    "rs": "-DROW_SWAPPING",
}

# Make compile dirs if they dont exist
for compiler_tag in compilers.keys():
    for flag in optimization_flags.keys():
        os.makedirs(os.path.join(build_dir, compiler_tag, flag), exist_ok=True)

# .c and .h files
c_files = []
include_dirs = set()

for dirpath, dirnames, filenames in os.walk(root_dir):
    for filename in filenames:
        full_path = os.path.realpath(os.path.join(dirpath, filename))
        if filename.endswith(".c"):
            c_files.append(full_path)
        elif filename.endswith(".h"):
            include_dirs.add(dirpath)


include_flags = [f"-I{d}" for d in include_dirs] + [
    "-lm",
    "-lopenblas",
]

for compiler_tag, compiler_name in compilers.items():
    subprocess.run(
        modules.get(compiler_tag),
        check=True,
    )
    for o_tag, o_flag in optimization_flags.items():
        for rs_tag, rs_flag in row_swapping.items():
            output_dir = os.path.join(build_dir, compiler_tag, o_tag)
            output_file = os.path.join(
                output_dir,
                f"dgesv{('_' + rs_tag) if rs_tag else ''}",
            )

            cmd = [compiler_name] + c_files + [o_flag] + include_flags
            if rs_flag:
                cmd.append(rs_flag)
            cmd += ["-o", output_file]

            print("Compiling:", " ".join(cmd))
            subprocess.run(cmd, check=True)
