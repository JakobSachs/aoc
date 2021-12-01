function count_increases(arr::Vector{Int32})
  count::UInt32 = 0

  for i in 2:length(arr)
    if arr[i] > arr[i-1]
      count += 1
    end
  end

  return count
end

measurements = parse.(Int32,readlines("input_day1.txt"))
inc_measurement = count_increases(measurements)

println("$inc_measurement measurements are larger then the previous measurement")

sums = [sum(measurements[i:i+2]) for i in 1:length(measurements)-2]
inc_sum = count_increases(sums)

println("$inc_sum sums are larger then the previous sum")


