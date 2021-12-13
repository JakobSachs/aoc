using BenchmarkTools, Printf, Suppressor, DataStructures

"Returns the given time (in nanoseconds) in a nice format"
function format_time(t::Float64)::String
  unit = ""
  if t > 1e9
    # print in seconds
    t /= 1e9
  elseif t > 1e6
    # print in milliseconds
    t /= 1e6
    unit = "m"
  elseif t > 1e3
    # print in microseconds
    t /= 1e3
    unit = "µ"
  else
    #print in nanoseconds\
    unit = "n"
  end

  res = @sprintf "%.3f " t
  res *= unit * "s"
  return res
end

"Returns the given memory-amount (in bytes) in a nice format"
function format_mem(b)::String
  unit = ""
  if b > 1024^3
    # print in GibiBytes
    b /= 1024^3
    unit = "Gi"
  elseif b > 1024^2
    # print in MebiBytes
    b /= 1024^2
    unit = "Mi"
  elseif b > 1024
    # print in KibiBytes
    b /= 1e3
    unit = "Ki"
  end

  res = @sprintf "%.3f " b
  res *= unit * "B"
  return res
end

files = readdir(dirname(@__DIR__) * "/aoc21/src")

if length(ARGS) == 0
  #run all benchmarks and output to benchmarks.md

  outputs = SortedDict{Int,String}()

  for f in files
    @suppress begin
      include(dirname(@__DIR__) * "/aoc21/src/" * f)
      using .Day
    end
    benchmark = @benchmarkable Day.main()
    tune!(benchmark)

    res = median(run(benchmark))

    t_out = format_time(res.time)
    m_out = format_mem(res.memory)


    day = split(split(f, ".")[1], "-")[2]
    outputs[parse(Int, day)] = "| " * day * " | " * t_out * " | " * m_out * " |\n"
  end

  isfile("benchmarks.md") && rm("benchmarks.md")

  open("benchmarks.md", "w") do io
    write(io, "| Day 📅| Time⏳ | Memory 💾 |\n")
    write(io, "| - | - | - |\n")

    for (_, output) in outputs
      write(io, output)
    end
    write(io, "\n")
  end


else
  for a in ARGS
    for f in files
      if a == split(split(f, ".")[1], "-")[2]
        @suppress begin
          include(dirname(@__DIR__) * "/aoc21/src/" * f)
          using .Day
        end

        benchmark = @benchmarkable Day.main()
        tune!(benchmark)

        res = median(run(benchmark))

        t_out = format_time(res.time)
        m_out = format_mem(res.memory)
        day = split(split(f, ".")[1], "-")[2]

        println("Day $(day):\t$(t_out)\t$(m_out)")
      end
    end
  end
end
