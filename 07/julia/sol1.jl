# Load input
using DelimitedFiles
inp = readdlm("../input", ',', Int) .+ 1

# Tally crab locations
m = maximum(inp)
crabs = zeros(Int, m)
view(crabs, inp) .+= 1

# Calculate distance travelled for each candidate location
distances = abs.(repeat(1:m, inner=(1,m))' .- (1:m))
travelled = distances * crabs

# Print the best
println(minimum(travelled))
