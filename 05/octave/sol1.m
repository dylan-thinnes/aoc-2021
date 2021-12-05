# Read inputs
inp = strrep(fileread("../input"), "->", ",");
inp = str2num(inp)+1

# Initialize array
width = max(max(inp(:,[1,3])));
height = max(max(inp(:,[2,4])));
field = zeros(width, height);

# Update indices
for l = inp'
  xstep = (l(1) < l(3)) * 2 - 1;
  xrange = l(1):xstep:l(3);

  ystep = (l(2) < l(4)) * 2 - 1;
  yrange = l(2):ystep:l(4);

  if l(1) == l(3) || l(2) == l(4)
    field(xrange, yrange) += 1;
  end
end

# Total gte 2
sum(sum(field >= 2, 1), 2)
