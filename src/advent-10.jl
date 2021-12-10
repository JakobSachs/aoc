module Day10

using DataStructures

global error_score = 0
global middle_completion_score = 0

function main()
  lines = readlines(dirname(@__DIR__) * "/data/input_day10.txt")


  brackets = Dict(')' => '(', '}' => '{', ']' => '[', '>' => '<')
  reverse_brackets = Dict('(' => ')', '{' => '}', '[' => ']', '<' => '>')
  error_values = Dict(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)
  completion_values = Dict(')' => 1, ']' => 2, '}' => 3, '>' => 4)



  error_score = 0
  completion_scores = []

  for l in lines

    stack = Stack{Char}()
    invalid = 0


    for (i, c) in enumerate(l)
      if c in ['(', '{', '[', '<']
        push!(stack, c)
      else
        if pop!(stack) != brackets[c]
          error_score += error_values[c]
          invalid = 1
          break
        end
      end
    end

    if invalid == 0
      score::Int = 0
      for s in stack
        score *= 5
        score += completion_values[reverse_brackets[s]]
      end
      push!(completion_scores, score)
    end
  end


  global error_score = error_score 


  sort!(completion_scores)
  middle = length(completion_scores) ÷ 2 + 1
  global middle_completion_score = completion_scores[middle]
end

function output()
  println("error score:\t\t$error_score")
  println("completion score:\t$middle_completion_score")
end
end


Day10.main()
Day10.output()