puts File.read("4").split("\n\n").map { |ps| ps.split.map { |e| e.split(":") }.to_h }.map { |ps|
  next unless %w[byr iyr eyr hcl ecl pid hgt].all? { |f| ps.key?(f) }
  [
    true,
    ps["byr"].to_i.between?(1920, 2002) &&
      ps["iyr"].to_i.between?(2010, 2020) &&
      ps["eyr"].to_i.between?(2020, 2030) &&
      ps["hcl"].match?(/^#[0-9a-f]{6}$/) &&
      ps["pid"].match?(/^[0-9]{9}$/) &&
      %w[amb blu brn gry grn hzl oth].include?(ps["ecl"]) &&
      (
        (ps["hgt"][-2..] == "cm" && ps["hgt"][..-2].to_i.between?(150, 193)) ||
        (ps["hgt"][-2..] == "in" && ps["hgt"][..-2].to_i.between?(59, 76))
      )
  ]
}.compact.transpose.map { |e| e.count(true) }
