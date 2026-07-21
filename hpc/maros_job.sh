#!/bin/bash
#PBS -l select=1:ncpus=2:mem=32gb
#PBS -l walltime=02:00:00
#PBS -N maros

module load Julia/1.11.6-linux-x86_64

# 1. Copy the project directory recursively to the compute node
cp -r $HOME/ClarabelBenchmarks $TMPDIR/

# 2. Enter the copied project directory
cd $TMPDIR/ClarabelBenchmarks

# 3. Instantiate the environment to ensure Manifest/Project are resolved
julia --project=. -e 'import Pkg; Pkg.instantiate()'

# 4. Run the script using the local directory as the project root
julia --project=. src/benchmarks/bench_maros.jl