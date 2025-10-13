import os
import subprocess
import definitions as defs

for compiler_tag in defs.compilers.keys():
    for flag in defs.optimization_flags.keys():
        os.makedirs(os.path.join(build_dir, compiler_tag, flag), exist_ok=True)
            