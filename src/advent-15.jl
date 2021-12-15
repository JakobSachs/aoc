module Day

using DataStructures

global lowest_risk_path = 0
global full_lowest_risk_path = 0

function main()
  lines::Vector = readlines(dirname(@__DIR__) * "/data/input_day15.txt")

  risk_map::Matrix = hcat([[parse(Int, c) for c in l] for l in lines]...)
  dim::Int = size(risk_map)[1]


  # adapted dijkstra's
  dist::Matrix = fill(typemax(Int), dim, dim)
  prev = Dict{Tuple,Tuple}()

  q = PriorityQueue{Tuple,Int}()

  for (idx, v) in pairs(risk_map)
    if idx != tuple(1, 1)
      dist[idx] = typemax(Int)
    end

    enqueue!(q, tuple(idx[1], idx[2]), dist[idx])
  end

  while !isempty(q)

    u::Tuple = dequeue!(q)

    if u == (dim, dim)
      break
    end

    nexts = [(u[1], u[2] + 1), (u[1], u[2] - 1), (u[1] + 1, u[2]), (u[1] - 1, u[2])]
    for v in nexts
      if v[1] ∈ 1:dim && v[2] ∈ 1:dim
        alt = dist[u[1], u[2]] + risk_map[v[1], v[2]]

        if alt < dist[v[1], v[2]]
          dist[v[1], v[2]] = alt
          prev[v] = u
          q[v] = alt
        end
      end
    end
  end

  path = Tuple[]

  u = (dim, dim)

  while u != (1, 1)
    pushfirst!(path, u)

    u = prev[u]
  end
  global lowest_risk_path = sum(map(p -> risk_map[p[1], p[2]], path))


  # part 2


  original_map::Matrix{Int} = risk_map


  # theres probably a better solution for this, but i cant be bothered right now
  risk_map = zeros(Int, dim * 5, dim * 5)
  for x = 0:4
    for y = 0:4

      cell = map(c -> ((c + x + y)), original_map)
      cell = map(c -> c > 9 ? c % 9 : c, cell)

      risk_map[x*dim+1:x*dim+dim, y*dim+1:y*dim+dim] = cell
    end
  end

  dim = size(risk_map)[1]

  dist = fill(typemax(Int), dim, dim)
  prev = Dict{Tuple,Tuple}()

  q = PriorityQueue{Tuple,Int}()

  for (idx, v) in pairs(risk_map)
    if idx != tuple(1, 1)
      dist[idx] = typemax(Int)
    end

    enqueue!(q, tuple(idx[1], idx[2]), dist[idx])
  end

  while !isempty(q)

    u = dequeue!(q)

    if u == (dim, dim)
      break
    end

    nexts = [(u[1], u[2] + 1), (u[1], u[2] - 1), (u[1] + 1, u[2]), (u[1] - 1, u[2])]
    for v in nexts
      if v[1] ∈ 1:dim && v[2] ∈ 1:dim
        alt = dist[u[1], u[2]] + risk_map[v[1], v[2]]

        if alt < dist[v[1], v[2]]
          dist[v[1], v[2]] = alt
          prev[v] = u
          q[v] = alt
        end
      end
    end
  end

  path = Tuple[]

  u = (dim, dim)

  while u != (1, 1)
    pushfirst!(path, u)

    u = prev[u]
  end
  global full_lowest_risk_path = sum(map(p -> risk_map[p[1], p[2]], path))
end

function output()
  println("Lowest risk path:\t\t$lowest_risk_path")
  println("Lowest risk path(full map):\t$full_lowest_risk_path")
end
end


if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end
