import sys
total = 0
for l in sys.stdin.readlines():
    l = l[:-1]
    pres, posts = l.split(" | ")
    digits = []

    one = None
    four = None
    seven = None
    eight = None
    for pre in pres.split(" "):
        if len(pre) == 2:
            one = set(pre)
        elif len(pre) == 4:
            four = set(pre)
        elif len(pre) == 3:
            seven = set(pre)
        elif len(pre) == 7:
            eight = set(pre)

    for post in posts.split(" "):
        if len(post) == 2:
            digits.append(1)
        elif len(post) == 4:
            digits.append(4)
        elif len(post) == 3:
            digits.append(7)
        elif len(post) == 7:
            digits.append(8)
        elif len(post) == 5:
            if seven.issubset(post):
                digits.append(3)
            elif four.difference(one).issubset(post):
                digits.append(5)
            else:
                digits.append(2)
        elif len(post) == 6:
            if four.issubset(post):
                digits.append(9)
            elif seven.issubset(post):
                digits.append(0)
            else:
                digits.append(6)
        else:
            raise Exception(f"Invalid input with {len(post)} digits!")

    result = int("".join([str(d) for d in digits]))
    print(result)
    total += result
print(total)
