using BenchmarkTools

# benchmark day 1
include("./advent-1.jl")
using .Day1  
benchmark_d1 = @benchmarkable Day1.main()
tune!(benchmark_d1)
median(run(benchmark_d1))
