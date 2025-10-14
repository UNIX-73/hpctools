#!/bin/bash
#SBATCH --job-name=hpc_tools_compiler_vectorization
#SBATCH --output=job_results_1c.out
#SBATCH --error=job_results_1c.err
#SBATCH --time=72:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G

module load cesga/2025

python scripts/benchmark_1c.py