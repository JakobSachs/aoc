module Day

using Statistics


global fuel_usage_part1 = 0
global fuel_usage_part2 = 0

function main()
  crab_positions::Array = parse.(Int, split(read(dirname(@__DIR__) * "/data/input_day7.txt", String),
    ',', keepempty = false))

  goal::Int = median(crab_positions)

  global fuel_usage_part1 = sum(abs.(crab_positions .- goal))
  global fuel_usage_part2 = minimum([sum(binomial.(abs.(crab_positions .- i) .+ 1, 2))
                                     for i = minimum(crab_positions):maximum(crab_positions)])
end

function output()
  println("fuel usage (part1):\t$fuel_usage_part1")
  println("fuel usage (part2):\t$fuel_usage_part2")
end
end


if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end
