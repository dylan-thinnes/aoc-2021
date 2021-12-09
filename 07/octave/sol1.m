# Load crabs
inp = str2num(fileread("../input")) + 1;
m = max(inp);
crabs = histc(inp, 1:m);

# Calculate distances
distances = abs(repmat(1:m, [m,1])' - (1:m));
travelled = distances * crabs';

# Print minimum distance
min(travelled)
