module Day4

using DelimitedFiles

function check_winner(record)
  for i = 1:size(record, 1)
    if all(record[i, :] .== 1) || all(record[:, i] .== 1)
      return true
    end
  end
  return false
end

function main()
  boards, game = readdlm("input_day4.txt", Int16, skipblanks = true, header = true)

  # part 1
  game = split(game[1], ',', keepempty = false)
  game = parse.(Int16, game)

  boards = [boards[i:i+4, :] for i = 1:5:size(boards)[1]]
  record = [zeros(Int16, size(boards[1])[1], size(boards[1])[1]) for i = 1:size(boards)[1]]

  winner = -1
  last_num = -1

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

  score = 0

  for x in pairs(IndexCartesian(), boards[winner])
    if record[winner][x[1]] == 0
      score += x[2]
    end
  end

  score *= last_num

  println("winner board:\t$(winner)\tscore:\t$score")

  # part 2

  tmp_boards = deepcopy(boards)
  tmp_record = deepcopy(record)

  last_num = -1
  for n in game
    for (b_idx, b) in enumerate(tmp_boards)
      for (idx, val) in pairs(IndexCartesian(), b)
        if val == n
          tmp_record[b_idx][idx] = 1
        end
      end
    end


    winners = []
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

  start_idx = findall(n -> n == last_num, game)[1]

  last_board = tmp_boards[1]
  last_record = tmp_record[1]

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

  winner_idx = findfirst(b -> last_board == b, boards)
  score = 0

  for x in pairs(IndexCartesian(), last_board)
    if last_record[x[1]] == 0
      score += x[2]
    end
  end

  score *= last_num

  println("looser board:\t$(winner_idx)\tscore:\t$score")



end

function output() end
end

Day4.main()
Day4.output()