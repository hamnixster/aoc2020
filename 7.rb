@input = File.read("7").gsub(/ bags?/, "").split("\n").map { |li| li.split(/ contain |, |\./) }

def bags_with_bag(colour)
  result = @input.select { |rule| rule[1..].any? { |inside| inside.include?(colour) } }.map(&:first)
  (result + result.map { |colour| bags_with_bag(colour) }).flatten.uniq
end

def bag_counter(colour, multi = 1)
  @input.find { |li| li.first == colour }[1..].map { |bag_count|
    match = bag_count.match(/(\d+)\s(.*)/)
    next 0 unless match
    count = match[1].to_i * multi
    bag_counter(match[2], count) + count
  }.sum
end

puts bags_with_bag("shiny gold").count, bag_counter("shiny gold")
