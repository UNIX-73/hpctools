import os
import subprocess
import definitions as defs


# Make compile dirs if they dont exist
for compiler_tag in defs.compilers.keys():
    for flag in defs.optimization_flags.keys():
        os.makedirs(os.path.join(defs.build_dir, compiler_tag, flag), exist_ok=True)

# .c and .h files
c_files = []
include_dirs = set()

for dirpath, dirnames, filenames in os.walk(defs.root_dir):
    for filename in filenames:
        full_path = os.path.realpath(os.path.join(dirpath, filename))
        if filename.endswith(".c"):
            c_files.append(full_path)
        elif filename.endswith(".h"):
            include_dirs.add(dirpath)


include_flags = [f"-I{d}" for d in include_dirs]
link_flags = ["-lm", "-lopenblas"]

for compiler_tag, compiler_name in defs.compilers.items():
    for o_tag, o_flag in defs.optimization_flags.items():
        for rs_tag, rs_flag in defs.row_swapping.items():
            output_dir = os.path.join(defs.build_dir, compiler_tag, o_tag)

            # paths
            output_file = os.path.join(
                output_dir,
                f"dgesv{('_' + rs_tag) if rs_tag else ''}",
            )

            asm_file = os.path.join(
                output_dir,
                f"dgesv{('_' + rs_tag) if rs_tag else ''}.S",
            )

            log_file = os.path.join(
                output_dir,
                f"compile_logs{('_' + rs_tag) if rs_tag else ''}.log",
            )

            # compilation
            cmd = [compiler_name] + c_files + [o_flag] + include_flags
            if rs_flag:
                cmd.append(rs_flag)
            cmd += ["-o", output_file]
            cmd += link_flags

            # asm compilation
            s_cmd = [compiler_name] + ["-S"] + c_files + [o_flag] + include_flags
            if rs_flag:
                s_cmd.append(rs_flag)
            s_cmd += ["-o", asm_file]

            print("Compiling:", f" ".join(cmd))
            module_cmd = defs.modules.get(compiler_tag)
            compile_cmd = " ".join(cmd)

            # binary
            full_cmd = f"{module_cmd} && {' '.join(cmd)} > {log_file} 2>&1"
            subprocess.run(["bash", "-lc", full_cmd], check=True)

            # asm
            s_cmd_full = f"{module_cmd} && {' '.join(s_cmd)}"
            subprocess.run(["bash", "-lc", s_cmd_full], check=True)