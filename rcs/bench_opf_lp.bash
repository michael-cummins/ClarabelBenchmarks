#!/bin/bash
#PBS -l select=1:ncpus=1:mem=32gb
#PBS -l walltime=03:00:00
#PBS -N opf_lp

module load Julia/1.11.6-linux-x86_64
module load Gurobi/11.0.0-GCCcore-12.3.0
module load MATLAB/2024b

# 1. Copy the project directory recursively to the compute node
cp -r $HOME/ClarabelBenchmarks $TMPDIR/
cp -r $HOME/QTQP.jl $TMPDIR/

# 2. Enter the copied project directory
cd $TMPDIR/ClarabelBenchmarks

# 3. Instantiate the environment to ensure Manifest/Project are resolved
# julia --project=. -e 'import Pkg; Pkg.rm(["Mosek", "MosekTools"]); Pkg.instantiate()'

# 4. Run the script using the local directory as the project root
julia --project=. "src/benchmarks/bench_opf_lp.jl"

# copy if done any project modifications
# cp $TMPDIR/ClarabelBenchmarks/Manifest.toml $HOME/ClarabelBenchmarks/
# cp $TMPDIR/ClarabelBenchmarks/Project.toml $HOME/ClarabelBenchmarks/

# Copy results files 
cp $TMPDIR/ClarabelBenchmarks/results/jld2/bench_opf_lp_QTQP.jld2 $HOME/ClarabelBenchmarks/results/jld2/
cp $TMPDIR/ClarabelBenchmarks/results/jld2/bench_opf_lp_ClarabelBenchmarks.QTQP_clarabel.jld2 $HOME/ClarabelBenchmarks/results/jld2/
cp $TMPDIR/ClarabelBenchmarks/results/jld2/bench_opf_lp_Clarabel.jld2 $HOME/ClarabelBenchmarks/results/jld2/

# copy plots
cp $TMPDIR/ClarabelBenchmarks/results/plots/bench_opf_lp_time.pdf $HOME/ClarabelBenchmarks/results/plots/
cp $TMPDIR/ClarabelBenchmarks/results/plots/bench_opf_lp_performance.pdf $HOME/ClarabelBenchmarks/results/plots/

# copy tables
cp $TMPDIR/ClarabelBenchmarks/results/tables/bench_opf_lp_sgm.tex $HOME/ClarabelBenchmarks/results/tables/