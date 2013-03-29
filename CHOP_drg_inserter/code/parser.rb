require_relative 'adapter'


class Parser
  attr_accessor :file
  def initialize (filename)
    self.file = File.open(File.dirname(__FILE__) + "/#{filename}")
  end
  def get_lines
    lines = []
    file.each_line() do |line|
      lines << line
    end
    lines
  end
end