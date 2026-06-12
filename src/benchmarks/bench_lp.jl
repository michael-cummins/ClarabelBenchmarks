# Run benchmarks on LP test set

# include any solvers you want to test 
using ClarabelBenchmarks, DataFrames, JLD2
using Clarabel, HiGHS, QTQP


solvers = [QTQP, Clarabel] 
class   = "lp"
verbose = false
time_limit = 180.
rerun = false

df = ClarabelBenchmarks.benchmark(
    solvers, class;
    time_limit = time_limit,
    verbose = verbose, tag = tag, rerun = rerun)

# include("src/benchmarks/bench_lp.jl"); include("src/benchmarks/bench_sslsq.jl"); include("src/benchmarks/bench_opf_lp.jl");