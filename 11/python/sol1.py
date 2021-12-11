import sys

# Setup global state
state = [[[int(c)] for c in list(line[:-1])] for line in sys.stdin.readlines()]
height = len(state)
width = len(state[0])
total = 0

# Step state forward by 1
def step():
    global state, total

    flashes = set()

    # Increment everyone, find fresh flashes
    for y, row in enumerate(state):
        for x, val in enumerate(row):
            val[0] += 1
            if val[0] > 9:
                flashes.add((x, y))
                val[0] = None

    # Increment neighbours until no flashes are produced
    while len(flashes) > 0:
        next_flashes = set()
        for cx, cy in flashes:
            val = state[cy][cx]
            total += 1
            for x in [cx-1, cx, cx+1]:
                for y in [cy-1, cy, cy+1]:
                    if 0 <= y < height and 0 <= x < width:
                        val = state[y][x]
                        if val[0] is not None:
                            val[0] += 1
                            if val[0] > 9:
                                next_flashes.add((x, y))
                                val[0] = None
        flashes = next_flashes

    # Turn all flashes into zeros
    for row in state:
        for val in row:
            if val[0] is None:
                val[0] = 0

for i in range(100):
    print(f"Step {i}")
    step()

print(total)
