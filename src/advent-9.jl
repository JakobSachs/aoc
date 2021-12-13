module Day

global risklevels = 0
global prod_of_basins = 0

using DataStructures

function main()
  lines = readlines(dirname(@__DIR__) * "/data/input_day9.txt")

  n = 100

  matrix::Matrix{Int} = fill(9, (n + 2, n + 2))
  low_points::Array{Tuple{Int,Int}} = []
  basin_map::Matrix{Int} = fill(-1, (n + 2, n + 2))


  for (i, l) in enumerate(lines)
    matrix[i+1, 2:n+1] = [parse(Int, c) for c in l]
    basin_map[i+1, 2:n+1] = [(9 != parse(Int, c) ? 0 : -1) for c in l]
  end

  counter = 0

  for x = 2:n+1
    for y = 2:n+1
      v = matrix[x, y]
      if (v < matrix[x+1, y] && v < matrix[x-1, y]
          && v < matrix[x, y+1] && v < matrix[x, y-1])
        counter += (v + 1)
        push!(low_points, tuple(x, y))
      end
    end
  end

  global risklevels = counter

  counts::SortedSet{Int} = SortedSet{Int}()

  for (i::Int, p::Tuple) in enumerate(low_points)
    c::Int = 0

    S::Stack = Stack{Tuple}()
    push!(S, p)

    while !isempty(S)
      t::Tuple = pop!(S)

      if basin_map[t[1], t[2]] != -1 && basin_map[t[1], t[2]] != i
        basin_map[t[1], t[2]] = i
        c += 1

        push!(S, tuple(t[1] + 1, t[2]))
        push!(S, tuple(t[1] - 1, t[2]))
        push!(S, tuple(t[1], t[2] + 1))
        push!(S, tuple(t[1], t[2] - 1))
      end
    end

    push!(counts, c)
  end

  global prod_of_basins = prod(collect(counts)[end-2:end])

end

function output()
  println("sum of risklevels:\t$risklevels")
  println("Product of top3 basins:\t$prod_of_basins")
end
end


if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end
