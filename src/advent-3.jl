module Day

global γ, ϵ
global oxygen_rate, CO2_rate

function count_bit(lines, bit)
  count_1 = count_0 = 0
  for l in lines
    if l[bit] == '1'
      count_1 += 1
    elseif l[bit] == '0'
      count_0 += 1
    end
  end
  return (count_0, count_1)
end

function main()

  lines = readlines(dirname(@__DIR__) * "/data/input_day3.txt")
  bits = length(lines[1])

  γ_tmp = ""
  ϵ_tmp = ""

  for i = 1:bits
    res = count_bit(lines, i)
    if res[1] <=res[2]
      γ_tmp *= "1"
      ϵ_tmp *= "0"
    else
      γ_tmp *= "0"
      ϵ_tmp *= "1"
    end
  end

  global γ = parse(Int, γ_tmp, base = 2)
  global ϵ = parse(Int, ϵ_tmp, base = 2)

  # calculate 'the oxygen rate'
  lines_tmp = deepcopy(lines)
  bit = 1

  while length(lines_tmp) > 1
    res = count_bit(lines_tmp, bit)

    if res[1] <= res[2]
      filter!(l->l[bit] == '1', lines_tmp)
    else
      filter!(l->l[bit] == '0', lines_tmp)
    end
    bit += 1
  end

  global oxygen_rate = parse(Int, first(lines_tmp),base=2)
  
  lines_tmp = deepcopy(lines)
  bit = 1

  while length(lines_tmp) > 1
    res = count_bit(lines_tmp, bit)

    if res[1] <= res[2]
      filter!(l->l[bit] == '0', lines_tmp)
    else
      filter!(l->l[bit] == '1', lines_tmp)
    end
    bit += 1
  end

  global CO2_rate = parse(Int, first(lines_tmp),base=2)
end

function output()
  println("γ:\t$γ\tϵ:\t$ϵ\tPower:\t$(γ*ϵ)")
  println("O2:\t$oxygen_rate\tCO2:\t$CO2_rate\tScore:\t$((oxygen_rate * CO2_rate))")
end
end

if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end
