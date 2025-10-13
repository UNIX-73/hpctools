#!/bin/bash
#SBATCH --exclusive
#SBATCH --job-name=hpc_tools_compiler_vectorization
#SBATCH --output=job_results.out
#SBATCH --error=job_results.err
#SBATCH --time=5:00:00
#SBATCH --cpus-per-task=64
#SBATCH --mem=64G

export OPENBLAS_NUM_THREADS=1 # https://stackoverflow.com/questions/72669579/c-how-to-set-environment-variable-so-openblas-runs-multithreaded
export OMP_NUM_THREADS=1

module load cesga/2025

python scripts/benchmark.py