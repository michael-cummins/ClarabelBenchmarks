using Revise
using ClarabelBenchmarks, Clarabel, JuMP, QTQP
SettingsDict = Dict{Symbol,Any}

settings_direct = SettingsDict(
    :kkt_solver => :direct,
    :verbose => false,
    :shifted_central_path => false,
    :equilibrate => :augmented,
    :init_strategy => :orthant,
    # :equilibrate => :none,
    :step_size_scale => 0.99,
    :max_iterative_refinement_steps => 20,
    :min_static_regularization => 1e-8,
    :iterative_refinement_stop_ratio => 1.0,
    :linear_solver_rtol=>1e-12,
    :linear_solver_atol=>1e-12
)

function test_single(problem, settings; bench="maros")
    model = Model(QTQP.Optimizer)
    for (key, value) in settings
        set_optimizer_attribute(model, string(key), value)
    end
    ClarabelBenchmarks.PROBLEMS[bench][problem](model)
    println("   solve time: ", solve_time(model))
    println("   status : $(termination_status(model))")
end

problems_netlib = [
    "perold", "agg2", "agg3", "pilot4",
    "greenbea", "pilot87", "pilotnov", "pilot_ja"
]

problems_maros = [
    "YAO", 
    "LISWET9", "LISWET8", "LISWET7", "LISWET12", "LISWET11",
    "LISWET10", "LISWET1"
]

problems_clarabel = [
    "QSHELL", "QPCBOEI2", "PRIMALC8"
]

for p ∈ problems_maros
    println("\nSolving $p")
    try
        test_single(p, settings_direct)
    catch
        println("   numerical error")
    end
end