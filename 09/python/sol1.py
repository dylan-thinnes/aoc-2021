import sys
inp = [[int(c) for c in line[:-1]] for line in sys.stdin.readlines()]
max_y = len(inp)
max_x = len(inp[0])

total = 0

for y, row in enumerate(inp):
    for x, val in enumerate(row):
        neighbours = [(x-1,y), (x+1,y), (x,y-1), (x,y+1)]
        neighbours = [(x, y) for x, y in neighbours if 0 <= x < max_x and 0 <= y < max_y]
        neighbours = [inp[y][x] for x, y in neighbours]

        if all([val < n for n in neighbours]):
            total += val + 1

print(total)
