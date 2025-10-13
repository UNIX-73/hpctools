#!/bin/bash
#SBATCH --job-name=hpc_tools_compiler_vectorization
#SBATCH --output=job_results.out
#SBATCH --error=job_results.err
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=32
#SBATCH --mem=32G
#SBATCH --ntasks=1

export OPENBLAS_NUM_THREADS=1 # https://stackoverflow.com/questions/72669579/c-how-to-set-environment-variable-so-openblas-runs-multithreaded

module load cesga/2025

python scripts/benchmark.py