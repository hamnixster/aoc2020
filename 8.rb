Instruction = Struct.new(:id, :code, :value, :visited_at) do
  def visited?
    !!visited_at
  end

  def jmp?
    code == "jmp"
  end

  def nop?
    code == "nop"
  end
end

input = File.read("8").split("\n").map.with_index do |instr, id|
  instr = instr.split
  Instruction.new(id, instr[0], instr[1].to_i, nil)
end

def run_intcode(prg)
  pointer, acc, count = 0, 0, 0
  while (instr = prg[pointer]) && !instr.visited?
    instr.visited_at = count
    count += 1
    case instr.code
    when "acc"
      acc += instr.value
      pointer += 1
    when "jmp"
      pointer += instr.value
    else
      pointer += 1
    end
  end
  acc
end

def find_swap_instr(prg, final_id: prg.last.id)
  candidates = []

  loop_id = final_id - 1
  upstream_range = loop {
    instr = prg[loop_id]
    if instr.visited?
      candidates << instr
      break [instr.id + 1, final_id]
    end
    if instr.jmp? && (instr.value <= 0 || instr.value > (final_id - instr.id + 1))
      break [instr.id + 1, final_id]
    end
    loop_id -= 1
  }

  candidates += prg.select { |instr|
    (instr.value + instr.id).between?(*upstream_range) &&
      !instr.id.between?(*upstream_range) &&
      ((instr.nop? && instr.visited?) || instr.jmp?)
  }

  candidates.map.with_index { |candidate, i|
    if candidate.jmp? && !candidate.visited?
      find_swap_instr(prg, final_id: candidate.id)
    else
      candidate
    end
  }.flatten.compact.uniq { |instr| instr.id }[0]
end

puts run_intcode(input)
find_swap_instr(input).tap { |instr| instr.code = instr.jmp? ? "nop" : "jmp" }
input.each { |instr| instr.visited_at = nil }
puts run_intcode(input)
