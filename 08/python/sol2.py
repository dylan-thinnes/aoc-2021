import sys
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
        if len(post) == 2:
            digit = 1
        elif len(post) == 4:
            digit = 4
        elif len(post) == 3:
            digit = 7
        elif len(post) == 7:
            digit = 8
        elif len(post) == 5:
            if seven.issubset(post):
                digit = 3
            elif four.difference(one).issubset(post):
                digit = 5
            else:
                digit = 2
        elif len(post) == 6:
            if four.issubset(post):
                digit = 9
            elif seven.issubset(post):
                digit = 0
            else:
                digit = 6
        else:
            raise Exception(f"Invalid input with {len(post)} digits!")

        result = result * 10 + digit

    total += result
print(total)
