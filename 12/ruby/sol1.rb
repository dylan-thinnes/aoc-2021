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
def ant(cave, history)
  new_history = history.clone
  new_history.add cave

  if cave == "end"
    $total += 1
  elsif not (/[[:lower:]]/.match cave and history.include? cave)
    $caverns[cave].each { ant _1, new_history }
  end
end

ant "start", Set.new
print $total, "\n"
