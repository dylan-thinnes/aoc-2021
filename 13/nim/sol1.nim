import sets
import system/io
import strscans

type Hole = tuple[y: int, x: int]

proc reflect(x: int, refl: bool, y: int): int =
  if refl and x > y: 2 * y - x else: x

var holes: HashSet[Hole]

for line in stdin.lines:
  var x, y, pos: int
  var dim: char

  if scanf(line, "$i,$i", x, y):
    holes.incl((y: y, x: x))

  elif scanf(line, "fold along $c=$i", dim, pos):
    var new_holes: HashSet[Hole]
    for hole in holes.items:
      var hole = hole
      hole.x = hole.x.reflect(dim == 'x', pos)
      hole.y = hole.y.reflect(dim == 'y', pos)
      new_holes.incl(hole)
    holes = new_holes

    break

echo holes.len
