require "set"

$caverns = Hash.new { |hash, key| hash[key] = [] }
$stdin.readlines.map do |line|
  a, b = line.chomp.split("-")

  if a != "end" and b != "start"
    $caverns[a].push(b)
  end

  if a != "start" and b != "end"
    $caverns[b].push(a)
  end
end

$total = 0
def ant(cave, history, doubled)
  new_history = history.clone
  new_history.add cave

  if cave == "end"
    $total += 1
  elsif /^[[:lower:]]+$/.match cave and history.include? cave
    if not doubled
      for next_cave in $caverns[cave]
        ant next_cave, new_history, true
      end
    end
  else
    for next_cave in $caverns[cave]
      ant next_cave, new_history, doubled
    end
  end
end

ant "start", Set.new, false
print $total, "\n"
