class Parser

  def parse
    puts "to be implemented"
  end

  def set_levels()
    self.entrylist.each do |reference|
      self.entrylist.each do |entry|
        unless reference == entry
          if (reference.code_first <= entry.code_first and reference.code_last >= entry.code_last)
            entry.raise_level
          end
        end
      end
    end
  end

  def write_entries()
    self.entrylist.each do |entry|
      self.outputfile.write(entry.to_s + "\n")
    end
  end

end