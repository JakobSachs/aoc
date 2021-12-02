using BenchmarkTools

# benchmark day 1
include("./advent-1.jl")
using .Day1  
benchmark_d1 = @benchmarkable Day1.main()
tune!(benchmark_d1)
println("Benchmark: \n")
display(median(run(benchmark_d1)))
println("\ndone!")

# benchmark day 2
include("./advent-2.jl")
using .Day2
benchmark_d2 = @benchmarkable Day2.main()
tune!(benchmark_d2)
println("Benchmark: \n")
display(median(run(benchmark_d2)))
println("\ndone!")