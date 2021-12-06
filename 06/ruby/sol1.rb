inp = $stdin.read.split(",").map { |x| x.to_i }

pop = Hash.new 0
inp.each { |x| pop[x] += 1 }

(1..80).each do |idx|
  new_pop = Hash.new 0
  pop.each do |key, value|
    if key == 0
      new_pop[8] += value
      new_pop[6] += value
    else
      new_pop[key - 1] += value
    end
  end
  pop = new_pop
end

puts pop.values.sum
