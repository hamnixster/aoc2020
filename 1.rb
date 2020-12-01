[2, 3].map { |p| puts File.read("1").split.map(&:to_i).combination(p).find { |a| a.sum == 2020 }.inject(:*) }
