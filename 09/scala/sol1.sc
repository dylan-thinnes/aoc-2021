import scala.io.Source
import scala.collection.mutable.Stack
import scala.collection.mutable.{Map => MutableMap}

// Load input
var inp = Source.fromFile("../input").getLines.map(_.chars.toArray).toArray

// Construct depths
var depths: MutableMap[(Int, Int), Int] = MutableMap.from((
  for {
    (row, y) <- inp.zipWithIndex
    (v, x) <- row.zipWithIndex
    if v != 57
  } yield ((y, x), v)
).toArray[((Int, Int), Int)])

// Neighbours' indices
def neighbours(yx: (Int, Int)): Array[(Int, Int)] = {
  val (y, x) = yx
  Array((y, x + 1), (y, x - 1), (y + 1, x), (y - 1, x))
}

// Calculate total
var total = 0

for {
  (yx, value) <- depths.toList
  if neighbours(yx).flatMap(depths.get(_)).forall(_ > value)
} total += value - 47

println(total)
