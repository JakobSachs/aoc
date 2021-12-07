module Day6

global fish_amount_80 = 0
global fish_amount_256 = 0

function simulate_day(fish_ages::Array)

  new_fish_ages = zeros(Int128, size(fish_ages))

  for (age, amount) in enumerate(fish_ages)
    if age > 1
      new_fish_ages[age-1] += amount
    else
      new_fish_ages[6+1] += amount
      new_fish_ages[8+1] += amount
    end
  end

  return new_fish_ages
end

function main()
  fish_ages::Array = zeros(Int128, 8 + 1)

  fish::Array = parse.(Int, split(read(dirname(@__DIR__) * "/data/input_day6.txt", String),
    ',', keepempty = false))

  for f in fish
    fish_ages[f+1] += 1
  end

  for _ = 1:80
    fish_ages = simulate_day(fish_ages)
  end

  global fish_amount_80 = sum(fish_ages)

  for _ = 81:256
    fish_ages = simulate_day(fish_ages)
  end

  global fish_amount_256 = sum(fish_ages)
end

function output()
  println("amount of fish after 80 days:\t$fish_amount_80")
  println("amount of fish after 256 days:\t$fish_amount_256")
end
end


Day6.main()
Day6.output()