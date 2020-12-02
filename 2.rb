part1, part2 = [0, 0]
File.read("2").gsub(/[:-]/, " ").split("\n").map do |pw|
  min, max, char, pw = pw.split
  min, max = [min, max].map(&:to_i)
  part1 += 1 if pw.count(char).between?(min, max)
  part2 += 1 if [min, max].map { |pos| pw[pos - 1] == char }.inject(:^)
end
puts part1, part2
