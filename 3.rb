m = File.read("3").split("\n")
a = [[1, 1], [1, 3], [1, 5], [1, 7], [2, 1]]
  .map { |v, h| m.each_slice(v).map.with_index { |l, i| l[0][i * h % l[0].size] }.count("#") }
puts a[1], a.inject(:*)
