module Day8

global counts = []

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
end

function output()
  println("amount of 1,4,7,8:\t$counts")
end
end


Day8.main()
Day8.output()