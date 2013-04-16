class Parser
  require_relative 'adapter'
  attr_accessor :file

  def initialize (filename)
    self.file = File.open(File.dirname(__FILE__) + "/#{filename}")
  end

  #@return an array of parsed MDC - FS documents
  def parse_documents
    documents = Array.new
    file.each_line() do |row|
      columns = row.split(',')
      mdc = columns[0]
      for i in 4..columns.size
        unless columns[i].nil?
          fmh = columns[i].gsub(/\s+/, "")
          unless fmh.nil?
            if fmh.length>0
              documents.push(create_document(mdc,fmh))
            end
          end
        end
      end
    end
    documents
  end

  def create_document(mdc, fmh)
    doc = {:fs_code=>fmh.to_i, :mdc_code=>mdc}
    doc
  end

end


