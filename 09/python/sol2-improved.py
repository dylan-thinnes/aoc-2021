import sys
inp = [[[int(c)] for c in line[:-1]] for line in sys.stdin.readlines()]

# Annotate inputs with adjacent elements
frontier = []
last_basin = 0

max_y = len(inp)
max_x = len(inp[0])
for y, row in enumerate(inp):
    for x, el in enumerate(row):
        # Find neighbours
        adj = [(x-1,y), (x+1,y), (x,y-1), (x,y+1)]
        adj = [(x, y) for x, y in adj if 0 <= x < max_x and 0 <= y < max_y]
        adj = [inp[y][x] for x, y in adj]

        # Annotate with neighbours, basin id
        el.append(None)
        el.append(adj)

        # Check if this is the seed of a basin
        if all([el[0] < a[0] for a in adj]):
            el[1] = last_basin
            last_basin += 1
            frontier.append(el)

# Keep expanding the frontier, up to borders with 9
while len(frontier) > 0:
    el = frontier.pop()
    print("Inspecting el ", el[0], el[1], len(el[2]))
    for a in el[2]:
        if a[0] != 9 and a[1] is None:
            a[1] = el[1]
            frontier.append(a)

# Calculate basin sizes
basin_sizes = [0] * last_basin
for row in inp:
    for val, basin, _ in row:
        if basin is not None:
            basin_sizes[basin] += 1
basin_sizes.sort(reverse=True)
print(basin_sizes[0] * basin_sizes[1] * basin_sizes[2])
