module Day10

using DataStructures

global error_score = 0
global middle_completion_score = 0

function main()
  lines = readlines(dirname(@__DIR__) * "/data/input_day10.txt")

  brackets::Dict = Dict(')' => '(', '}' => '{', ']' => '[', '>' => '<')
  reverse_brackets::Dict = Dict('(' => ')', '{' => '}', '[' => ']', '<' => '>')
  error_values::Dict = Dict(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)
  completion_values::Dict = Dict(')' => 1, ']' => 2, '}' => 3, '>' => 4)

  lcl_error_score::Int = 0
  completion_scores::Array = []

  for l in lines

    stack::Stack = Stack{Char}()
    invalid::Bool = false


    for (i, c) in enumerate(l)
      if c in ['(', '{', '[', '<']
        push!(stack, c)
      else
        if pop!(stack) != brackets[c]
          lcl_error_score += error_values[c]
          invalid = true
          break
        end
      end
    end

    if !invalid
      score::Int = 0
      for s in stack
        score *= 5
        score += completion_values[reverse_brackets[s]]
      end
      push!(completion_scores, score)
    end
  end


  global error_score = lcl_error_score


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