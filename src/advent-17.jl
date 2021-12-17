module Day

global max_height = 0
global successfull_velocities = 0

function step!(probe::Vector{Int})
  probe[1] += probe[3]
  probe[2] += probe[4]

  probe[4] -= 1

  if probe[3] > 0
    probe[3] -= 1
  elseif probe[3] < 0
    probe[3] += 1
  end
end

function check_target(probe::Vector{Int}, area::Vector{Int})
  if probe[1] ∈ area[1]:area[2] && probe[2] ∈ area[3]:area[4]
    return true
  end
  return false
end


function main()
  input::String = read(dirname(@__DIR__) * "/data/input_day17.txt", String)

  area_x, area_y = split(input, ", ")

  _, area_x = split(area_x, "=")
  _, area_y = split(area_y, "=")

  area = vcat(parse.(Int, (split(area_x, ".."))), parse.(Int, (split(area_y, ".."))))

  # didnt expect this naive approach to actually work
  # might improve this in the future

  successfull_vels = Vector[]


  for x = 1:500 # seems like a reasonable range to search in
    for y = -500:500
      local_max = 0

      probe = [0, 0, x, y]
      while true
        if probe[2] > local_max
          local_max = probe[2]
        end
        if check_target(probe, area)
          push!(successfull_vels, [x, y])
          if local_max > max_height
            global max_height = local_max
          end
          break
        elseif probe[1] > area[2] || (probe[2] < area[4] && probe[4] < 0) || (probe[2] > area[3] && probe[4] > 0)
          break
        end

        step!(probe)
      end
    end
  end


  global successfull_velocities = length(successfull_vels)
end

function output()
  println("max height:\t\t$(max_height)")
  println("unique velocities:\t$(successfull_velocities)")
end
end


if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end
