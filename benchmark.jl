using BenchmarkTools

for arg in Base.ARGS
  
  if arg == "1"
    # benchmark day 1
    include("./advent-1.jl")
    using .Day1  
    benchmark_d1 = @benchmarkable Day1.main()
    tune!(benchmark_d1)
    println("Benchmark: \n")
    display(median(run(benchmark_d1)))
    println("\ndone!")
  elseif arg == "2"    
    # benchmark day 2
    include("./advent-2.jl")
    using .Day2
    benchmark_d2 = @benchmarkable Day2.main()
    tune!(benchmark_d2)
    println("Benchmark: \n")
    display(median(run(benchmark_d2)))
    println("\ndone!")
  elseif arg == "3"
    # benchmark day 3
    include("./advent-3.jl")
    using .Day3
    benchmark_d3 = @benchmarkable Day3.main()
    tune!(benchmark_d3)
    println("Benchmark: \n")
    display(median(run(benchmark_d3)))
    println("\ndone!")
  end
end


