# Run benchmarks on optimal control problems

# include any solvers you want to test 
using ClarabelBenchmarks, DataFrames, JLD2
using Revise
using Clarabel, QTQP, ECOS, OSQP

solvers = [Clarabel, QTQP, OSQP]
tag     = nothing
class   = "mpc"
verbose = false
time_limit = 300.
rerun = true
plotlist = [Clarabel, QTQP, OSQP]

df = ClarabelBenchmarks.benchmark(
    solvers, class;
    time_limit = time_limit,
    verbose = verbose, 
    tag = tag, 
    rerun = rerun,
    plotlist = plotlist)