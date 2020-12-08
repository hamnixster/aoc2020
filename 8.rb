input = File.read("8").split("\n").map { |ins| ins.split.tap { |ins| ins[-1] = ins.last.to_i } }
part1_input = Marshal.load(Marshal.dump(input))

def run_intcode(instructions)
  pointer, acc = 0, 0
  while (inc = 1) && (ins = instructions[pointer]) && (val = ins[1]) && ins[-1] != "visited"
    ins << "visited"
    case ins.first
    when "acc"
      acc += val
    when "jmp"
      inc = val
    end
    pointer += inc
  end
  acc
end

def find_candidate_swaps(input, start = nil)
  start ||= input.size - 1
  bottom, top = start - 1, start
  range_to_reach = loop {
    bottom_ins = input[bottom]
    return bottom if bottom_ins[-1] == "visited"
    if (val = bottom_ins[1]) &&
        bottom_ins[0] == "jmp" &&
        (val <= 0 || val > (top - bottom) + 1)
      break [bottom + 1, top]
    end
    bottom -= 1
  }

  input.select.with_index { |ins, pos|
    code, val = ins[..2]
    (val + pos).between?(*range_to_reach) &&
      (
        (code == "jmp" && val != 1) ||
        (code == "nop" && ins[-1] == "visited")
      )
  }.map { |candidate|
    find_candidate_swaps(input, input.index(candidate))
  }.flatten
end

puts run_intcode(part1_input)

find_candidate_swaps(part1_input).each do |candidate|
  part2_input = Marshal.load(Marshal.dump(input))
  part2_input[candidate][0] = part2_input[candidate][0] == "jmp" ? "nop" : "jmp"
  acc = run_intcode(part2_input)
  break puts acc if part2_input[-1][-1] == "visited"
end
