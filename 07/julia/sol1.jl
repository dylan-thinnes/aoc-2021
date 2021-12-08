# Load input
using DelimitedFiles
inp = readdlm("../input", ',', Int)

# Tally crab locations
m = maximum(inp)+1
locations = zeros(Int, m)
for i in inp
  locations[i+1] += 1
end

# Distance travelled
best = Inf
best_idx = 0
for i in 1:m
  distances = abs.((1:m) .- i)
  travelled = sum(distances .* locations)
  if travelled < best
    global best = travelled
    global best_idx = i
  end
end
