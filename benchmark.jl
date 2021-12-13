using BenchmarkTools

for arg in Base.ARGS

  if arg == "1"
    # benchmark day 1
    include("./src/advent-1.jl")
    using .Day1
    benchmark_d1 = @benchmarkable Day1.main()
    tune!(benchmark_d1)
    println("Benchmark: \n")
    display(median(run(benchmark_d1)))
    println("\ndone!")
  elseif arg == "2"
    # benchmark day 2
    include("./src/advent-2.jl")
    using .Day2
    benchmark_d2 = @benchmarkable Day2.main()
    tune!(benchmark_d2)
    println("Benchmark: \n")
    display(median(run(benchmark_d2)))
    println("\ndone!")
  elseif arg == "3"
    # benchmark day 3
    include("./src/advent-3.jl")
    using .Day3
    benchmark_d3 = @benchmarkable Day3.main()
    tune!(benchmark_d3)
    println("Benchmark: \n")
    display(median(run(benchmark_d3)))
    println("\ndone!")
  elseif arg == "4"
    # benchmark day 4
    include("./src/advent-4.jl")
    using .Day4
    benchmark_d4 = @benchmarkable Day4.main()
    tune!(benchmark_d4)
    println("Benchmark: \n")
    display(median(run(benchmark_d4)))
    println("\ndone!")
  elseif arg == "5"
    # benchmark day 5
    include("./src/advent-5.jl")
    using .Day5
    benchmark_d5 = @benchmarkable Day5.main()
    tune!(benchmark_d5)
    println("Benchmark: \n")
    display(median(run(benchmark_d5)))
    println("\ndone!")
  elseif arg == "6"
    # benchmark day 6
    include("./src/advent-6.jl")
    using .Day6
    benchmark_d6 = @benchmarkable Day6.main()
    tune!(benchmark_d6)
    println("Benchmark: \n")
    display(median(run(benchmark_d6)))
    println("\ndone!")
  elseif arg == "7"
    # benchmark day 7
    include("./src/advent-7.jl")
    using .Day7
    benchmark_d7 = @benchmarkable Day7.main()
    tune!(benchmark_d7)
    println("Benchmark: \n")
    display(median(run(benchmark_d7)))
    println("\ndone!")
  elseif arg == "8"
    # benchmark day 78
    include("./src/advent-8.jl")
    using .Day8
    benchmark = @benchmarkable Day8.main()
    tune!(benchmark)
    println("Benchmark: \n")
    display(median(run(benchmark)))
    println("\ndone!")
  elseif arg == "9"
    # benchmark day 9
    include("./src/advent-9.jl")
    using .Day9
    benchmark = @benchmarkable Day9.main()
    tune!(benchmark)
    println("Benchmark: \n")
    display(median(run(benchmark)))
    println("\ndone!")
  elseif arg == "10"
    # benchmark day 10
    include("./src/advent-10.jl")
    using .Day10
    benchmark = @benchmarkable Day10.main()
    tune!(benchmark)
    println("Benchmark: \n")
    display(median(run(benchmark)))
    println("\ndone!")
  elseif arg == "11"
    # benchmark day 11
    include("./src/advent-11.jl")
    using .Day11
    benchmark = @benchmarkable Day11.main()
    tune!(benchmark)
    println("Benchmark: \n")
    display(median(run(benchmark)))
    println("\ndone!")
  elseif arg == "12"
    # benchmark day 11
    try
      include("./src/advent-12.jl")
      using .Day12
      benchmark = @benchmarkable Day12.main()
      tune!(benchmark)
      println("Benchmark: \n")
      display(median(run(benchmark)))
      println("\ndone!")
    catch e
    end
  elseif arg == "13"
    # benchmark day 11
    try
      include("./src/advent-13.jl")
      using .Day13
      benchmark = @benchmarkable Day13.main()
      tune!(benchmark)
      println("Benchmark: \n")
      display(median(run(benchmark)))
      println("\ndone!")
    catch e
    end
  end


end


