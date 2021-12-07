module Day4

using DelimitedFiles

global winner_score = 0
global looser_score = 0

function check_winner(record::Matrix{Int16})
  :Bool
  for i = 1:size(record, 1)
    if record[i, :] == [1,1,1,1,1] || record[:, i] == [1,1,1,1,1]
      return true
    end
  end
  return false
end

function main()
  boards_r, game = readdlm(dirname(@__DIR__) * "/data/input_day4.txt", Int16, skipblanks = true, header = true)

  # part 1
  game = split(game[1], ',', keepempty = false)
  game = parse.(Int16, game)

  boards::Vector{Matrix{Int16}} = [boards_r[i:i+4, :] for i = 1:5:size(boards_r)[1]]
  record::Vector{Matrix{Int16}} = [zeros(Int16, size(boards[1])[1], size(boards[1])[1]) for i = 1:size(boards)[1]]


  winner::Int16 = -1
  last_num::Int16 = -1

  for n in game
    for (b_idx, b) in enumerate(boards)
      for (idx, val) in pairs(IndexCartesian(), b)
        if val == n
          record[b_idx][idx] = 1
        end
      end
    end


    for (r_idx, r) in enumerate(record)
      if check_winner(r)
        winner = r_idx
        last_num = n
        break
      end
    end

    if winner != -1
      break
    end
  end

  score::Int64 = 0

  for x in pairs(IndexCartesian(), boards[winner])
    if record[winner][x[1]] == 0
      score += x[2]
    end
  end

  score *= last_num

  global winner_score = score

  # part 2
  tmp_boards::Vector{Matrix{Int16}} = deepcopy(boards)
  tmp_record::Vector{Matrix{Int16}} = deepcopy(record)

  last_num = -1
  for n in game
    for (b_idx, b) in enumerate(tmp_boards)
      for (idx, val) in pairs(IndexCartesian(), b)
        if val == n
          tmp_record[b_idx][idx] = 1
        end
      end
    end


    winners::Array{Int16} = []
    for (r_idx, r) in enumerate(tmp_record)
      if check_winner(r)
        append!(winners, r_idx)
      end
    end

    if length(winners) > 0
      deleteat!(tmp_boards, winners)
      deleteat!(tmp_record, winners)
    end



    if size(tmp_boards)[1] == 1
      last_num = n
      break
    end
  end

  # continue playing for last board

  start_idx::Int16 = findall(n -> n == last_num, game)[1]

  last_board::Matrix{Int16} = tmp_boards[1]
  last_record::Matrix{Int16} = tmp_record[1]

  for n in game[start_idx:end]
    for (idx, val) in pairs(IndexCartesian(), last_board)
      if val == n
        last_record[idx] = 1
      end
    end

    if check_winner(last_record)
      last_num = n
      break
    end
  end

  score = 0

  for x in pairs(IndexCartesian(), last_board)
    if last_record[x[1]] == 0
      score += x[2]
    end
  end

  score *= last_num
  global looser_score = score
end

function output()
  println("winner score:\t$winner_score")
  println("looser score:\t$looser_score")
end
end

Day4.main()
Day4.output()