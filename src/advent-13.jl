module Day

global points_after_first = 0
global code_dots = []

function parse_dot(in::String)::Vector{Int}
  x, y = parse.(Int, split(in, ','))
  return [x, y]
end

function parse_fold(in::String)::Tuple{Bool,Int}
  dim, l = split(in, '=')
  l = parse(Int, l)
  dim = dim[end] == 'x' ? true : false
  return (dim, l)
end

function display_field(dots::Vector{Vector{Int}})
  max_y = maximum([d[2] for d in dots])
  max_x = maximum([d[1] for d in dots])

  field = [[" " for j = 1:max_x+1] for i = 1:max_y+1]

  for d in dots
    field[d[2]+1][d[1]+1] = "█"
  end

  for l in field
    for c in l
      print(c)
    end
    println()
  end
  println()
end

function do_fold!(dots::Vector{Vector{Int}}, fold::Tuple{Bool,Int})
  if fold[1] # do fold on x axis
    for d in dots
      if d[1] > fold[2]
        d[1] = 2 * fold[2] - d[1]
      end
    end
  else # do fold on y axis
    for d in dots
      if d[2] > fold[2]
        d[2] = 2 * fold[2] - d[2]
      end
    end
  end

  unique!(dots)
end

function main()
  lines = readlines(dirname(@__DIR__) * "/data/input_day13.txt")
  dots = parse_dot.(lines[begin:findfirst([l == "" for l in lines])-1])
  folds = parse_fold.(lines[findfirst([l == "" for l in lines])+1:end])

  # part 1
  do_fold!(dots, folds[1])

  global points_after_first = length(dots)

  for i = 2:length(folds)
    do_fold!(dots, folds[i])
  end

  global code_dots = dots
end

function output()
  println("Amount of points after first fold:\t$(points_after_first)")
  println("Code: ")
  display_field(code_dots)
end
end


if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end
