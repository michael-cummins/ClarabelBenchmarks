# Run benchmarks on optimal control problems

# include any solvers you want to test 
using ClarabelBenchmarks, DataFrames, JLD2
using Revise
using Clarabel, QTQP, ECOS, OSQP

solvers = [QTQP, Clarabel]
tag     = nothing
class   = "mpc"
verbose = true
time_limit = 5.
rerun = false
plotlist = [QTQP, Clarabel]

df = ClarabelBenchmarks.benchmark(
    solvers, class;
    time_limit = time_limit,
    verbose = verbose, 
    tag = tag, 
    rerun = rerun,
    plotlist = plotlist)

show(df, allrows=true)