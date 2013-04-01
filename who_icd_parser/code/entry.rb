class Entry
  attr_accessor :title, :code_first, :code_last, :level

  def initialize(title, code_first, code_last)
    self.title=title
    self.code_first = code_first
    self.code_last = code_last
    self.level = 1
  end
  def raise_level
    self.level+=1
  end

  def to_s
    "#{self.level};#{self.code_first};#{self.code_last};#{self.title};"
  end

end