input = File.read("9").split("\n").map(&:to_i)

preamble, pointer = 25, 25
invalid = loop {
  unless input[pointer - preamble...pointer].combination(2).map(&:sum).include?(input[pointer])
    break input[pointer]
  end
  pointer += 1
}

puts invalid

input.map.with_index { |n, i|
  next if n == invalid
  sum, idx = 0, i
  loop do
    break if sum >= invalid
    sum += n
    idx += 1
    n = input[idx]
  end
  break puts input[i...idx].minmax.sum if sum == invalid
}
