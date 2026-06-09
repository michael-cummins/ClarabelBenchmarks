using ClarabelBenchmarks, Clarabel, JuMP
model = ClarabelBenchmarks.PROBLEMS["maros"]["AUG2DQP"](QTQP_orthant.Optimizer)
println("solve time: ", solve_time(model))
