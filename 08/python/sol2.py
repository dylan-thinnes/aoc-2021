import sys

def discern_digit(one, four, seven, post):
    if len(post) == 2:
        return 1
    elif len(post) == 4:
        return 4
    elif len(post) == 3:
        return 7
    elif len(post) == 7:
        return 8
    elif len(post) == 5:
        if seven.issubset(post):
            return 3
        elif four.difference(one).issubset(post):
            return 5
        else:
            return 2
    elif len(post) == 6:
        if four.issubset(post):
            return 9
        elif seven.issubset(post):
            return 0
        else:
            return 6

    raise Exception(f"Invalid input with {len(post)} digits!")

total = 0
for l in sys.stdin.readlines():
    l = l[:-1]
    pres, posts = l.split(" | ")

    for pre in pres.split(" "):
        if len(pre) == 2:
            one = set(pre)
        elif len(pre) == 4:
            four = set(pre)
        elif len(pre) == 3:
            seven = set(pre)

    result = 0
    for post in posts.split(" "):
        result = result * 10 + discern_digit(one, four, seven, post)

    total += result
print(total)
