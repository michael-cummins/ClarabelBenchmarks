# Run benchmarks on netlib feasible LPs

# include any solvers you want to test 
using ClarabelBenchmarks, DataFrames, JLD2
using Clarabel, QTQP, OSQP
using Revise
# using Gurobi, MosekTools
# using ClarabelRs

solvers = [QTQP_orthant, Clarabel]
tag     = nothing
class   = "netlib_feasible"
verbose = false
time_limit = 300.
rerun   = false
plotlist = [QTQP_orthant,Clarabel]

df = ClarabelBenchmarks.benchmark(
    solvers, class;
    time_limit = time_limit,
    verbose = verbose, 
    tag = tag, 
    rerun = rerun,
    plotlist = plotlist)

show(df, allrows=true)