#!/bin/bash
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -l walltime=00:35:00
#PBS -N solve_single

module load Julia/1.11.6-linux-x86_64
module load Gurobi/11.0.0-GCCcore-12.3.0
module load MATLAB/2024b

# 1. Copy the project directory recursively to the compute node
cp -r $HOME/ClarabelBenchmarks $TMPDIR/
cp -r $HOME/QTQP.jl $TMPDIR/

# 2. Enter the copied project directory
cd $TMPDIR/ClarabelBenchmarks

# 3. Instantiate the environment to ensure Manifest/Project are resolved
julia --project=. -e 'import Pkg; Pkg.rm(["Mosek", "MosekTools"]); Pkg.instantiate()'

# 4. Run the script using the local directory as the project root
julia --project=. solve_single.jl

cp $TMPDIR/ClarabelBenchmarks/Manifest.toml $HOME/ClarabelBenchmarks/

# 5. Retrieve output files (TMPDIR is purged upon job completion)
# Modify the path below to target where your script saves its outputs
# cp -r $TMPDIR/QTQP.jl/experiments/results $HOME/QTQP.jl/experiments/