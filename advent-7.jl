module Day7

global fuel_usage_part1 = 0
global fuel_usage_part2 = 0

function main()
  crab_positions::Array = parse.(Int, split(read("input_day7.txt", String),
    ',', keepempty = false))

  global fuel_usage_part1 = minimum([sum(abs.(crab_positions .- i))
                                     for i = minimum(crab_positions):maximum(crab_positions)])
  global fuel_usage_part2 = minimum([sum(binomial.(abs.(crab_positions .- i) .+ 1, 2))
                                     for i = minimum(crab_positions):maximum(crab_positions)])
end

function output()
  println("fuel usage (part1):\t$fuel_usage_part1")
  println("fuel usage (part2):\t$fuel_usage_part2")
end
end


Day7.main()
Day7.output()