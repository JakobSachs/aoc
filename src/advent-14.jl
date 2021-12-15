module Day

global count_dif_10 = 0
global count_dif_40 = 0

function main()
  lines::Vector = readlines(dirname(@__DIR__) * "/data/input_day14.txt")

  poly_template::String = lines[1]
  rules = Dict{String,String}()

  for l in lines[3:end]
    pair::String, insrt::String = strip.(split(l, "->"), ' ')

    rules[pair] = insrt
  end


  naive_pairs::Vector = [lines[1][i:i+1] for i = 1:length(lines[1])-1]
  pair_counts::Dict = Dict{String,Int}()

  for p in naive_pairs
    if p ∉ keys(pair_counts)
      pair_counts[p] = 0
    end
    pair_counts[p] += 1
  end

  for _ = 1:10
    new_pair_counts = Dict{String,Int}()

    for (p, count) in pair_counts
      if p ∈ keys(rules)
        new_pair_1 = p[1] * rules[p]
        new_pair_2 = rules[p] * p[2]

        if new_pair_1 ∈ keys(new_pair_counts)
          new_pair_counts[new_pair_1] += count
        else
          new_pair_counts[new_pair_1] = count
        end
        if new_pair_2 ∈ keys(new_pair_counts)
          new_pair_counts[new_pair_2] += count
        else
          new_pair_counts[new_pair_2] = count
        end
      else
        if p ∈ keys(new_pair_counts)
          new_pair_counts[p] += count
        else
          new_pair_counts[p] = count
        end
      end
    end

    pair_counts = new_pair_counts
  end


  counts::Dict = Dict{Char,Int}()

  for (p, count) in pair_counts
    if p[1] ∉ keys(counts)
      counts[p[1]] = 0
    end
    counts[p[1]] += count
  end

  # account for last character in polymer String
  counts[lines[1][end]] += 1

  global count_dif_10 = maximum(values(counts)) - minimum(values(counts))

  # this would be better if we just continuted after step 10 

  naive_pairs = [lines[1][i:i+1] for i = 1:length(lines[1])-1]
  pair_counts = Dict{String,Int}()

  for p in naive_pairs
    if p ∉ keys(pair_counts)
      pair_counts[p] = 0
    end
    pair_counts[p] += 1
  end

  for _ = 1:40
    new_pair_counts = Dict{String,Int}()

    for (p, count) in pair_counts
      if p ∈ keys(rules)
        new_pair_1 = p[1] * rules[p]
        new_pair_2 = rules[p] * p[2]

        if new_pair_1 ∈ keys(new_pair_counts)
          new_pair_counts[new_pair_1] += count
        else
          new_pair_counts[new_pair_1] = count
        end
        if new_pair_2 ∈ keys(new_pair_counts)
          new_pair_counts[new_pair_2] += count
        else
          new_pair_counts[new_pair_2] = count
        end
      else
        if p ∈ keys(new_pair_counts)
          new_pair_counts[p] += count
        else
          new_pair_counts[p] = count
        end
      end
    end

    pair_counts = new_pair_counts
  end

  counts = Dict{Char,Int}()

  for (p, count) in pair_counts
    if p[1] ∉ keys(counts)
      counts[p[1]] = 0
    end
    counts[p[1]] += count
  end

  # account for last character in polymer String
  counts[lines[1][end]] += 1

  global count_dif_40 = maximum(values(counts)) - minimum(values(counts))

end

function output()
  println("count difference(10):\t$(count_dif_10)")
  println("count difference(40):\t$(count_dif_40)")
end
end


if abspath(PROGRAM_FILE) == @__FILE__
  Day.main()
  Day.output()
end
