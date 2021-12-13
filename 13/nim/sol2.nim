import sets
import system/io
import strscans
import strutils

type Hole = tuple[y: int, x: int]

proc reflect(a: int, refl: bool, b: int): int =
  if refl and a > b: 2 * b - a else: a

# Read holes, reflect on folds
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

# Print image, constructed by indices into string
var max_x, max_y = 0
for hole in holes:
  max_x = max_x.max(hole.x)
  max_y = max_y.max(hole.y)

var field = (' '.repeat(max_x + 1) & "\n").repeat(max_y + 1)

for hole in holes:
  var idx = hole.x + hole.y * (max_x + 2)
  field[idx] = '#'

echo field
