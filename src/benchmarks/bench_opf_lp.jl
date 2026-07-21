# Run benchmarks on LP problems from PowerModels.jl

# include any solvers you want to test 
using ClarabelBenchmarks, DataFrames, JLD2
using Clarabel, QTQP, HiGHS

solvers = [QTQP, QTQP_clarabel, Clarabel]
tag     = nothing
class   = "opf_lp"
verbose = false
time_limit = 300.
rerun = false
plotlist = [QTQP, QTQP_clarabel, Clarabel]

df = ClarabelBenchmarks.benchmark(
    solvers, class;
    time_limit = time_limit,
    verbose = verbose, 
    tag = tag, 
    rerun = rerun,
    plotlist = plotlist)

show(df, allrows=true)
