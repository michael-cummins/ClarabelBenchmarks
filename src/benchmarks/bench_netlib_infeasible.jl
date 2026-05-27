# Run benchmarks on netlib infeasible LPs

# include any solvers you want to test 
using ClarabelBenchmarks, DataFrames, JLD2
using Clarabel, QTQP
using Revise

solvers = [Clarabel,QTQP]
tag     = nothing
class   = "netlib_infeasible"
verbose = false
time_limit = 300.
rerun   = true
plotlist = [Clarabel,QTQP]

# these status codes count as "success" for  
# the purpose of performance profiles
ok_status = ["INFEASIBLE","DUAL_INFEASIBLE","PRIMAL_INFEASIBLE"]

df = ClarabelBenchmarks.benchmark(
    solvers, class;
    time_limit = time_limit,
    ok_status = ok_status,
    verbose = verbose, 
    tag = tag, 
    rerun = rerun,
    plotlist = plotlist)