#!/bin/bash
#SBATCH --job-name=hpc_tools_compiler_vectorization
#SBATCH --output=job_results.out
#SBATCH --error=job_results.err
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=32
#SBATCH --mem=32G
#SBATCH --ntasks=1

module load cesga/2025

python scripts/benchmark.py