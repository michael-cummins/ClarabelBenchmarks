# Run benchmarks on Maros-Meszaros problems

# include any solvers you want to test 
using ClarabelBenchmarks, DataFrames, JLD2
using Clarabel, QTQP
# using Gurobi, MosekTools
# using ClarabelRs

solvers = [QTQP_pardiso, QTQP]
tag     = nothing
class   = "maros"
verbose = false
time_limit = 300.
rerun = true
plotlist = [QTQP_pardiso, QTQP]


df = ClarabelBenchmarks.benchmark(
    solvers, class;
    time_limit = time_limit,
    verbose = verbose, 
    tag = tag, 
    rerun = rerun,
    plotlist = plotlist)

show(df, allrows=true)