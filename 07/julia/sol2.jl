# Load input
using DelimitedFiles
inp = readdlm("../input", ',', Int)

# Tally crab locations
m = maximum(inp)+1
crabs = zeros(Int, m)
for i in inp
  crabs[i+1] += 1
end

# Calculate distance travelled for each candidate location
distances = abs.(repeat(1:m, inner=(1,m))' .- (1:m))
distances = (distances .* distances .+ distances) .÷ 2
travelled = distances * crabs

# Print the best
println(minimum(travelled))
