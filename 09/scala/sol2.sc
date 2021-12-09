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

// Initialize frontier
var frontier: Stack[((Int, Int), Int)] = Stack.from({
  var i = 0
  for {
    (yx, value) <- depths.toList
    if neighbours(yx).flatMap(depths.get(_)).forall(_ > value)
  } yield {
    i += 1
    (yx, i - 1)
  }
})

// Count basin elements until all elements have been explored
var basins = Array.ofDim[Int](frontier.length)

while (frontier.nonEmpty) {
  val (target, basin) = frontier.pop()
  val removed_value = depths.remove(target)
  if (!removed_value.isEmpty) basins(basin) += 1
  frontier ++= neighbours(target).withFilter(depths.contains(_)).map((_, basin))
}

// Print sum of three largest basins
basins = basins.sorted.reverse
val result = basins(0) * basins(1) * basins(2)
println(result)
