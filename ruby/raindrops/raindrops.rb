# frozen_string_literal: true

# Raindrops class
class Raindrops
  MATCH = begin
    match = { 3 => 'Pling', 5 => 'Plang', 7 => 'Plong' }
    match.default = ''
    match.freeze
  end
  # @param number [Integer]
  # @return [String]
  def self.convert(number)
    # @type [String]
    ret = [3, 5, 7].reduce "" do |acc, by|
      acc += MATCH[by] if (number % by).zero?
      acc
    end
    return number.to_s unless ret.length.positive?

    ret
  end
end
