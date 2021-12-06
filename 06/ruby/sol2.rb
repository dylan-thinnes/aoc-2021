pop = Array.new 9, 0
$stdin.read.split(",").each { |x| pop[x.to_i] += 1 }

(1..256).each do |idx|
  pop.rotate! 1
  pop[6] += pop[8]
end

puts pop.sum
