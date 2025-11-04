import os
import subprocess
import definitions as defs

for compiler_tag in defs.compilers.keys():
    for flag in defs.optimization_flags.keys():
        os.makedirs(
            os.path.join(defs.vec_manual_build_dir, compiler_tag, flag, "asm", "dgesv"),
            exist_ok=True,
        )
        os.makedirs(
            os.path.join(
                defs.vec_manual_build_dir, compiler_tag, flag, "asm", "dgesv_rs"
            ),
            exist_ok=True,
        )

c_files = []
include_dirs = set()
for dirpath, dirnames, filenames in os.walk(defs.src_vec_manual_dir):
    for filename in filenames:
        full_path = os.path.realpath(os.path.join(dirpath, filename))
        if filename.endswith(".c"):
            c_files.append(full_path)
        elif filename.endswith(".h"):
            include_dirs.add(dirpath)

include_flags = [f"-I{d}" for d in include_dirs]
link_flags = ["-lm", "-lopenblas"]

for compiler_tag, compiler_name in defs.compilers.items():
    module_cmd = defs.modules.get(compiler_tag)

    for o_tag, o_flag in defs.optimization_flags.items():
        for rs_tag, rs_flag in defs.row_swapping.items():
            output_dir = os.path.join(defs.vec_manual_build_dir, compiler_tag, o_tag)

            output_file = os.path.join(
                output_dir, f"dgesv{('_' + rs_tag) if rs_tag else ''}"
            )
            log_file = os.path.join(
                output_dir, f"compile_logs{('_' + rs_tag) if rs_tag else ''}.log"
            )

            cmd = (
                [compiler_name] + c_files + [o_flag] + ["-march=native"] + include_flags
            )
            if rs_flag:
                cmd.append(rs_flag)
            cmd += ["-o", output_file] + link_flags

            print("Compiling binary:", " ".join(cmd))
            full_cmd = f"{module_cmd} && {' '.join(cmd)} > {log_file} 2>&1"

            # compile standard
            subprocess.run(["bash", "-lc", full_cmd], check=True)

            # asm
            asm_dir = os.path.join(
                output_dir, "asm", f"dgesv{('_' + rs_tag) if rs_tag else ''}"
            )
            os.makedirs(asm_dir, exist_ok=True)

            for c_file in c_files:
                base_name = os.path.splitext(os.path.basename(c_file))[0]
                asm_file = os.path.join(asm_dir, f"{base_name}.S")

                s_cmd = [compiler_name, "-S", c_file, o_flag] + include_flags
                if rs_flag:
                    s_cmd.append(rs_flag)
                s_cmd += ["-o", asm_file]

                print("Generating .S:", " ".join(s_cmd))
                s_cmd_full = f"{module_cmd} && {' '.join(s_cmd)}"
                subprocess.run(["bash", "-lc", s_cmd_full], check=True)
