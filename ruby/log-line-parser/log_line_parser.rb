# frozen_string_literal: true

# The class for the thing
class LogLineParser
  # @param [String]
  def initialize(line)
    @line = line
  end

  MESSAGES = %i[info error warning].freeze

  def message
    msgs = Regexp.new(MESSAGES
                 .map(&:upcase)
                 .join('|'))
    rx = / *\[#{msgs}\]:[ \t]*/
    @line
      .strip
      .sub(rx, "")
  end

  def log_level
    MESSAGES
      .map(&:to_s)
      .select { @line.include?(_1) or @line.include?(_1.upcase) }[0]
  end

  def reformat
    message + " (#{log_level})"
  end
end
