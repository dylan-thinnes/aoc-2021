fh = open("../input")
inp = [[[int(c)] for c in list(line[:-1])] for line in fh.readlines()]

height = len(inp)
width = len(inp[0])

def pretty():
    print()
    for row in inp:
        for val in row:
            if val[0] is None:
                print("█", end="")
            else:
                print(f"{val[0]:x}", end="")
        print()
    print()

#pretty()

flashes = 0
def step():
    global inp, flashes

    frontier = set()
    for y, row in enumerate(inp):
        for x, val in enumerate(row):
            val[0] += 1
            if val[0] is not None and val[0] > 9:
                frontier.add((x, y))

    #pretty()

    while len(frontier) > 0:
        new_frontier = set()
        for x,y in frontier:
            val = inp[y][x]
            val[0] = None

        for x,y in frontier:
            val = inp[y][x]
            flashes += 1
            for dx in [-1,0,1]:
                for dy in [-1,0,1]:
                    if 0 <= (y+dy) < height and 0 <= (x+dx) < width:
                        val = inp[y+dy][x+dx]
                        if val[0] is not None:
                            val[0] += 1
                            if val[0] > 9:
                                new_frontier.add((x+dx, y+dy))
        frontier = new_frontier

    #pretty()

    for row in inp:
        for val in row:
            if val[0] is None:
                val[0] = 0

i = 1
while True:
    print(f"Step {i}")
    i += 1
    step()
    simul = all([val[0] == 0 for row in inp for val in row])
    if simul:
        break

print(flashes)
