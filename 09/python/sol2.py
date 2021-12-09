import sys
inp = [[[int(c)] for c in line[:-1]] for line in sys.stdin.readlines()]
max_y = len(inp)
max_x = len(inp[0])

# Annotate inputs with adjacent elements
for y, row in enumerate(inp):
    for x, el in enumerate(row):
        # Adjacent
        adj = [(x-1,y), (x+1,y), (x,y-1), (x,y+1)]
        adj = [(x, y) for x, y in adj if 0 <= x < max_x and 0 <= y < max_y]
        adj = [inp[y][x] for x, y in adj]

        el.append(None)
        el.append(adj)

# Pretty-printer for the map
def print_basins():
    for row in inp:
        for val, basin, _ in row:
            if basin is not None:
                print(f"\x1b[3{1 + basin % 6};1m{val}\x1b[0m", end='')
            else:
                print(val, end='')
        print()
    print()

last_basin = 0

update_made = True
while update_made:
    update_made = False
    for row in inp:
        for el in row:
            val, basin, adj = el
            if basin is None and val != 9:
                # Check if surrounded by higher/equal
                locked = all([v >= val or basin is not None for v, basin, _ in adj])

                # Tally adjacent basins
                adj_basins = set([basin for _, basin, _ in adj if basin is not None])

                # Attach a (possibly new) basin if conditions met
                if locked and len(adj_basins) <= 1:
                    update_made = True

                    if len(adj_basins) == 1:
                        basin_idx = adj_basins.pop()
                    else:
                        basin_idx = last_basin
                        last_basin += 1
                    el[1] = basin_idx

print_basins()

basin_sizes = [0] * last_basin
for row in inp:
    for val, basin, _ in row:
        if basin is not None:
            basin_sizes[basin] += 1
basin_sizes.sort(reverse=True)
print(basin_sizes[0] * basin_sizes[1] * basin_sizes[2])
