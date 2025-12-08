#!/bin/bash
#SBATCH --exclusive
#SBATCH --job-name=hpc_tools_compiler_vectorization
#SBATCH --output=job_results_1c.out
#SBATCH --error=job_results_1c.err
#SBATCH --time=30:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G

module load cesga/2025 openblas imkl

python scripts/benchmark_1c_task3.py