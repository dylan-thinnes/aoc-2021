# Read inputs
inp = strrep(fileread("../input"), "->", ",");
inp = str2num(inp)+1

# Initialize array
width = max(max(inp(:,[1,3])));
height = max(max(inp(:,[2,4])));
field = zeros(width, height);

# Update indices
for l = inp'
  xr = l(1):((l(1)<l(3))*2-1):l(3);
  yr = l(2):((l(2)<l(4))*2-1):l(4);
  if l(1) == l(3) || l(2) == l(4)
    field(xr, yr) += 1;
  end
end

# Total gte 2
sum(sum(field >= 2, 1), 2)
