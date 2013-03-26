require_relative 'entry'
require_relative 'parser'

class WhoFileparser < Parser
  attr_accessor :inputfile, :outputfile, :entrylist

  def initialize (filename, outputfilename)
    self.inputfile = File.open(File.dirname(__FILE__) + "/#{filename}")
    self.outputfile = File.open(File.dirname(__FILE__) + "/#{outputfilename}", 'w')
    self.entrylist = []
  end


  def parse
    inputfile.each_line() do |line|
      if line.match('[A-Z]\d\d-[A-Z]\d\d<\/a>')
        coderange = line.match('[A-Z]\d\d-[A-Z]\d\d<\/a>').to_s
        coderange.slice!('</a>')

        code_arr = coderange.split('-')
        code_first = code_arr.first
        code_last = code_arr.last


        title_raw = line.match('title="(.+)" ').to_s
        title_arr = title_raw.split('"')
        title = title_arr[1]
        entry = Entry.new(title, code_first, code_last)
        entrylist << entry
      end
    end
    self.set_levels
    self.write_entries
  end


end