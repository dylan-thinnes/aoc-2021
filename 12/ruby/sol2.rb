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
  elsif /[[:lower:]]/.match cave and history.include? cave
    if not doubled
      $caverns[cave].each { ant _1, new_history, true }
    end
  else
    $caverns[cave].each { ant _1, new_history, doubled }
  end
end

ant "start", Set.new, false
print $total, "\n"
