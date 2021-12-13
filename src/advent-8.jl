module Day

global counts = []
global output_sum = 0

function main()
  lines = readlines(dirname(@__DIR__) * "/data/input_day8.txt")


  inputs = []
  outputs = []

  for l in lines
    pushfirst!(inputs, split(l, "|")[1])
    pushfirst!(outputs, split(l, "|")[2])
  end

  counters = [0, 0, 0, 0] # counters for 1,4,7,8

  for l in outputs
    for n in split(l, ' ')
      if length(n) == 2
        counters[1] += 1
      elseif length(n) == 4
        counters[2] += 1
      elseif length(n) == 3
        counters[3] += 1
      elseif length(n) == 7
        counters[4] += 1
      end
    end
  end

  global counts = sum(counters)

  sum_local = 0

  for (l, l_out) in zip(inputs, outputs)

    values_dict = Dict{Int,String}()

    for n in split(l, ' ')
      if length(n) == 2
        values_dict[1] = n
      elseif length(n) == 4
        values_dict[4] = n
      elseif length(n) == 3
        values_dict[7] = n
      elseif length(n) == 7
        values_dict[8] = n
      end
    end



    for n in split(l, ' ')
      if length(n) == 5 && length(intersect(n, values_dict[4])) == 2
        values_dict[2] = n
      end
    end

    for n in split(l, ' ')
      if length(n) == 5 && length(intersect(n, values_dict[2])) == 4
        values_dict[3] = n
      end
    end

    for n in split(l, ' ')
      if length(n) == 5 && (length(setdiff(n, values_dict[3])) == 1) && (n ∉ values(values_dict))
        values_dict[5] = n
      end
    end


    for n in split(l, ' ')
      if length(n) == 6 && length(intersect(n, values_dict[4])) == 4
        values_dict[9] = n
      end
    end

    for n in split(l, ' ')
      if length(n) == 6 && length(intersect(n, values_dict[4])) == 3 && length(intersect(n, values_dict[1])) == 1
        values_dict[6] = n
      end
    end

    for n in split(l, ' ')
      if length(n) == 6 && length(intersect(n, values_dict[4])) == 3 && length(intersect(n, values_dict[1])) == 2
        values_dict[0] = n
      end
    end


    output_code = ""

    for n in split(l_out, ' ')
      for i = 0:9
        if Set(n) == Set(values_dict[i])
          output_code *= string(i)
        end
      end
    end

    sum_local += parse(Int, output_code)

  end

  global output_sum = sum_local
end

function output()
  println("amount of 1,4,7,8:\t$counts")
  println("sum of outputs:\t\t$output_sum")
end
end


if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end
