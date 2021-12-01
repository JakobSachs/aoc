measurements = parse.(Int32,readlines("input_day1.txt"))

global inc_measurement = 0

for i in 2:length(measurements)
  if measurements[i] > measurements[i-1]
      global inc_measurement +=  1
  end
end

println("$inc_measurement measurements are larger then the previous measurement")

global sums = []

for i in 1:length(measurements)-2
  append!(sums,measurements[i]+measurements[i+1]+measurements[i+2])
end

global inc_sum = 0
for i in 2:length(sums)
    if sums[i] > sums[i-1]
        global inc_sum +=  1
    end
end

println("$inc_sum sums are larger then the previous sum")