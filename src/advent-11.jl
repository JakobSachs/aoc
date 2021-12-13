module Day11



using PaddedViews, DataStructures
global flashes_100 = 0
global synchronized_step = 0

function inc_neigbouring_cells!(squids::Matrix{Int}, x::Int, y::Int)
  perms = [(0, 1), (0, -1),
    (1, 1), (1, -1), (1, 0),
    (-1, 1), (-1, -1), (-1, 0),]

  if checkbounds(Bool, squids, x, y)
    for p in perms
      if checkbounds(Bool, squids, x + p[1], y + p[2])
        squids[x+p[1], y+p[2]] += 1
      end
    end
  end
end

function main()
  lines = readlines(dirname(@__DIR__) * "/data/input_day11.txt")
  dim = length(lines)
  squids_orig::Matrix{Int} = zeros(Int, dim, dim)

  for (i, l) in enumerate(lines)
    for (j, c) in enumerate(l)
      squids_orig[i, j] = parse(Int, c)
    end
  end

  steps = 100
  flash_counter = 0

  squids = deepcopy(squids_orig)
  for i = 1:steps
    squids .+= 1
    flashed::Matrix{Bool} = fill(false, dim, dim)

    while true
      should_flash = findall(s -> s > 9, squids)

      if length(should_flash) == 0
        break
      end

      squids[should_flash] .= 0
      flashed[should_flash] .= true

      for f in should_flash
        inc_neigbouring_cells!(squids, f[1], f[2])
      end
    end

    for f in findall(flashed)
      squids[f] = 0
      flash_counter += 1
    end
  end

  global flashes_100 = flash_counter

  # part 2
  i = 0

  squids = deepcopy(squids_orig)
  for _ = 1:1e8 # assuming that the synch step is < 1e8 
    i += 1
    squids .+= 1
    flashed::Matrix{Bool} = fill(false, dim, dim)

    while true
      should_flash = findall(s -> s > 9, squids)

      if length(should_flash) == 0
        break
      end

      squids[should_flash] .= 0
      flashed[should_flash] .= true

      for f in should_flash
        inc_neigbouring_cells!(squids, f[1], f[2])
      end
    end

    if length(findall(flashed)) == 100
      display(flashed)
      println("sync")
      break
    end

    for f in findall(flashed)
      squids[f] = 0
    end

    
  end

  global synchronized_step = i

end

function output()
  println("Flashes (after 100 steps):\t$flashes_100")
  println("Syncronized step:\t$synchronized_step")
end
end


Day11.main()
Day11.output()