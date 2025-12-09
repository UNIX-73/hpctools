#!/bin/bash
#SBATCH --exclusive
#SBATCH --job-name=hpc_tools_compiler_vectorization
#SBATCH --output=job_results_1c.out
#SBATCH --error=job_results_1c.err
#SBATCH --time=5:15:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G

COMPILER="icc"

module load cesga/2025 openblas imkl

python scripts/benchmark_compiler/${COMPILER}.py