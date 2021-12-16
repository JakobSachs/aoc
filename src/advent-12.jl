module Day

global path_count = 0
global path_count_modified = 0

mutable struct Cave
  id::String
  big::Bool
  adjacent::Vector{Cave}
end

function search_caves(v::Cave, visited_small_caves::Vector{String})
  if v.id == "end"
    global path_count += 1
    return
  end

  if !v.big
    push!(visited_small_caves, v.id)
  end

  for u in v.adjacent
    if u.id ∉ visited_small_caves
      search_caves(u, copy(visited_small_caves))
    end
  end
end

function search_caves_modified(v::Cave, visited_small_caves::Vector{String},
  double_visited::String)

  if v.id == "end"
    global path_count_modified += 1
    return
  end

  if !v.big
    push!(visited_small_caves, v.id)
  end

  for u in v.adjacent
    if u.id ∉ visited_small_caves
      search_caves_modified(u, copy(visited_small_caves), double_visited)
    elseif double_visited == "" && u.id ∉ ["start", "end"]
      search_caves_modified(u, copy(visited_small_caves), u.id)
    end
  end
end

function main()
  edges = readlines(dirname(@__DIR__) * "/data/input_day12.txt")
  caves = Dict{String,Cave}()

  for e in edges
    v1, v2 = split(e, "-")

    if v1 ∉ keys(caves)
      caves[v1] = Cave(v1, all(c -> isuppercase(c), v1), [])
    end
    if v2 ∉ keys(caves)
      caves[v2] = Cave(v2, all(c -> isuppercase(c), v2), [])
    end

    push!(caves[v1].adjacent, caves[v2])
    push!(caves[v2].adjacent, caves[v1])
  end

  search_caves(caves["start"], String[])
  search_caves_modified(caves["start"], String[], "")
end

function output()
  println("possible paths:\t$(path_count)")
  println("possible paths_modified:\t\t$(path_count_modified)")
end
end

if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end