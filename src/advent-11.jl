module Day11



using PaddedViews, DataStructures
global flashes_100 = 0

function main()
  squids = zeros(Int, 10 + 2, 10 + 2)

  lines = readlines(dirname(@__DIR__) * "/data/input_day11.txt")

  for (i, l) in enumerate(lines)
    for (j, c) in enumerate(l)
      squids[i+1, j+1] = parse(Int, c)
    end
  end

  dim = length(lines)

  steps = 100
  flash_counter = 0

  for i = 1:steps
    flashed = Set{Tuple}()
    for x = 1:dim
      for y = 1:dim

        s = squids[x+1, y+1]
        if s < 9
          squids[x+1, y+1] += 1
        else

          neighbours = Queue{Tuple}()

          enqueue!(neighbours, (x, y))

          while !isempty(neighbours)

            (x_i, y_i) = dequeue!(neighbours)

            if x_i ∈ 1:dim && y_i ∈ 1:dim

              squids[x_i+1, y_i+1] += 1

              if squids[x_i+1, y_i+1] >= 9 && (x_i, y_i) ∉ flashed

                flash_counter += 1

                push!(flashed, (x_i, y_i))

                enqueue!(neighbours, (x_i, y_i + 1))
                enqueue!(neighbours, (x_i - 1, y_i + 1))
                enqueue!(neighbours, (x_i + 1, y_i + 1))

                enqueue!(neighbours, (x_i, y_i - 1))
                enqueue!(neighbours, (x_i - 1, y_i - 1))
                enqueue!(neighbours, (x_i + 1, y_i - 1))

                enqueue!(neighbours, (x_i + 1, y_i))
                enqueue!(neighbours, (x_i - 1, y_i))

              end
            end
          end
        end
      end
    end

    for f in flashed
      squids[f[1]+1, f[2]+1] = 0
    end

  end

  global flashes_100 = flash_counter
end

function output()
  println("Flashes (after 100 steps):\t$flashes_100")
end
end


Day11.main()
Day11.output()