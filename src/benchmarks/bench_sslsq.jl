# Run benchmarks on Suite-sparse least squares benchmarks

# include any solvers you want to test 
using ClarabelBenchmarks, DataFrames, JLD2
using Clarabel, QTQP, HiGHS


solvers = [Clarabel,QTQP]
tag     = nothing
class   = "sslsq"
verbose = false
time_limit = 300.
rerun = false
plotlist = [Clarabel,QTQP]


df = ClarabelBenchmarks.benchmark(
    solvers, class;
    time_limit = time_limit,
    verbose = verbose,
    tag = tag,
    rerun = rerun,
    plotlist = plotlist)