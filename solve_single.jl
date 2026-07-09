using ClarabelBenchmarks, Clarabel, JuMP, QTQP
SettingsDict = Dict{Symbol,Any}

settings_indirect = SettingsDict(
    :atol => 1e-3,
    :rtol => 1e-3,
    :linear_solver_atol => 1e-12,
    :linear_solver_rtol => 1e-12,
    :kkt_solver => :indirect,
    :indirect_solve_method => :gmres,
    :indirect_preconditioner => :partial_cholesky,
    :partial_cholseky_rank => 100,
    :verbose => true
)

settings_direct = SettingsDict(
    :kkt_solver => :direct,
    :verbose => true,
    :shifted_central_path => false,
    :step_size_scale => 0.99,
    :max_iterative_refinement_steps => 10,
    :linear_solver_rtol => 1e-12
)

function test_single(problem, settings; bench="maros")
    model = Model(QTQP.Optimizer)
    for (key, value) in settings
        set_optimizer_attribute(model, string(key), value)
    end
    ClarabelBenchmarks.PROBLEMS[bench][problem](model)
    println("solve time: ", solve_time(model))
end

problems = [
    "agg2", "agg3", "pilot4",
    "greebea", "pilot87", "pilotnov", "pilot_ja"
]
shifted_iters = []
normal_iters = []

function test_shift(problems, shifted_iters, normal_iters, settings_direct)
    for p in problems
        for shift_flag ∈ [true, false]
            model = Model(QTQP.Optimizer)
            for (key, value) in settings_direct
                set_optimizer_attribute(model, string(key), value)
            end
            set_optimizer_attribute(model, "shifted_central_path", shift_flag)
            try
                ClarabelBenchmarks.PROBLEMS["netlib_feasible"][p](model)
                println("solve time: ", solve_time(model))
                shift_flag == true ? push!(shifted_iters, solve_time(model)) : push!(normal_iters, solve_time(model))
            catch
                shift_flag == true ? push!(shifted_iters, Inf) : push!(normal_iters, Inf)
            end
        end
    end
    return problems, shifted_iters, normal_iters
end

# problems, shifted_iters, normal_iters = test_shift(problems, shifted_iters, normal_iters)

# for (p, s, n) ∈ zip(problems, shifted_iters, normal_iters)
#     println("$p : shfited = $s, normal = $n")
# end