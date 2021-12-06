module Day5

global overlap_count_simple = 0
global overlap_count_diagonal = 0

function parse_line(line::String)::Tuple
  vals = split(line, "->")

  val_1 = parse.(Int16, split(vals[1], ","))
  val_2 = parse.(Int16, split(vals[2], ","))

  return tuple(tuple(val_1[1], val_1[2]), tuple(val_2[1], val_2[2]))
end

function main()
  field::Matrix = zeros(Int16, (1000, 1000))

  for l in readlines("input_day5.txt")
    n_l::Tuple = parse_line(l)
    dist = n_l[2] .- n_l[1]

    if n_l[1][1] == n_l[2][1] ## check for vertical line
      if n_l[1][2] <= n_l[2][2]
        field[n_l[1][1], n_l[1][2]:n_l[2][2]] .+= 1
      else
        field[n_l[1][1], n_l[2][2]:n_l[1][2]] .+= 1
      end
    elseif n_l[1][2] == n_l[2][2] ## check for horizontal line

      if n_l[1][1] <= n_l[2][1]
        field[n_l[1][1]:n_l[2][1], n_l[1][2]] .+= 1
      else
        field[n_l[2][1]:n_l[1][1], n_l[1][2]] .+= 1
      end
    end
  end

  global overlap_count_simple = count(x -> x >= 2, field)

  field = zeros(Int16, (1000, 1000))
  for l in readlines("input_day5.txt")
    n_l::Tuple = parse_line(l)
    dist = n_l[2] .- n_l[1]

    if n_l[1][1] == n_l[2][1] ## check for vertical line
      if n_l[1][2] <= n_l[2][2]
        field[n_l[1][1], n_l[1][2]:n_l[2][2]] .+= 1
      else
        field[n_l[1][1], n_l[2][2]:n_l[1][2]] .+= 1
      end
    elseif n_l[1][2] == n_l[2][2] ## check for horizontal line

      if n_l[1][1] <= n_l[2][1]
        field[n_l[1][1]:n_l[2][1], n_l[1][2]] .+= 1
      else
        field[n_l[2][1]:n_l[1][1], n_l[1][2]] .+= 1
      end

    elseif abs(dist[1]) == abs(dist[2]) ## check for diagonal line

      if dist[1] > 0
        if dist[2] > 0
          for i = 0:abs(dist[1])
            field[n_l[1][1]+i, n_l[1][2]+i] += 1
          end
        else
          for i = 0:abs(dist[1])
            field[n_l[1][1]+i, n_l[1][2]-i] += 1
          end
        end
      else
        if dist[2] > 0
          for i = 0:abs(dist[1])
            field[n_l[1][1]-i, n_l[1][2]+i] += 1
          end
        else
          for i = 0:abs(dist[1])
            field[n_l[1][1]-i, n_l[1][2]-i] += 1
          end
        end
      end
    end
  end


  global overlap_count_diagonal = count(x -> x >= 2, field)

end

function output()
  println("Overlap count(simpler):\t\t$overlap_count_simple")
  println("Overlap count(diagonals):\t$overlap_count_diagonal")
end
end


Day5.main()
Day5.output()