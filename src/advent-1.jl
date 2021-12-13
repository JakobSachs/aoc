module Day

function count_increases(arr::Vector)
  count::UInt32 = 0

  for i = 2:length(arr)
    if arr[i] > arr[i-1]
      count += 1
    end
  end

  return count
end

global inc_measurement = 0
global inc_sum = 0

function main()
  measurements = parse.(Int16, readlines(dirname(@__DIR__) * "/data/input_day1.txt"))
  global inc_measurement = count_increases(measurements)

  sums = [sum(measurements[i:i+2]) for i = 1:length(measurements)-2]
  global inc_sum = count_increases(sums)
end

function output()
  println("$inc_measurement measurements are larger then the previous measurement")
  println("$inc_sum sums are larger then the previous sum")
end
end


if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end
