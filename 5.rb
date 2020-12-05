ans = File.read("5").split.map do |li|
  row, seat = li.tr("FLBR", "0011").partition(/.{7}/)[1..].map { |n| n.to_i(2) }
  row * 8 + seat
end.sort
puts ans.max, ans.find { |id| !ans.include?(id + 1) } + 1
