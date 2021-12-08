import sys
total = 0
for l in sys.stdin.readlines():
    l = l[:-1]
    before, after = l.split(" | ")
    for out in after.split(" "):
        if len(out) in [2,4,3,7]:
            total += 1
print(total)
