module Day2
  global horizontal
  global depth 

  function main()
    global horizontal = 0
    global depth = 0
    aim = 0
    for l in eachline("input_day2.txt")
      if l[1] == 'u'
        aim -= parse(Int,last(l,2))
      elseif l[1] == 'd'
        aim += parse(Int,last(l,2))
      elseif l[1] == 'f'
        global horizontal += parse(Int,last(l,2))
        global depth += (aim * parse(Int,last(l,2)))
      end
    end
  end

  function output()
    println("Horizontal: $horizontal Depth: $depth")
    println("Total: $(horizontal * depth)")
  end
end

Day2.main()
Day2.output()