input = File.read("6").split("\n\n")
puts input.map { |grp| grp.tr("\n", "").split(//).uniq.count }.sum,
  input.map { |grp| grp.split.map { |li| li.split(//) }.inject(:&) }.map(&:count).sum
