class Parser
  require_relative 'adapter'
  attr_accessor :file
  def initialize
    filename = 'data.csv'
    self.file = File.new(filename)
  end

  def parse_documents
    documents = Array.new
    file.each_line() do |row|
      columns = row.split(";")
      mdc = columns[0]
      for i in 1..columns.size
        unless columns[i].nil?
          fmh = columns[i].gsub(" ","")
          puts fmh
          unless fmh.nil?
            if fmh.length>0
              documents.push(create_document(mdc,columns[i]))
            end
          end
        end
      end
    end
    documents
  end

  def create_document(mdc, fmh)
    doc = "{:fs_code=>#{fmh}, :mdc_code=>#{mdc}}"
    doc.gsub!("\n","")
    doc
  end

end


