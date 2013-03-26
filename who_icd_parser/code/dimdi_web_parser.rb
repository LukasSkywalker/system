require 'open-uri'
require_relative 'entry'

class DimdiWebParser<Parser
  attr_accessor :outputfile, :entrylist, :source
  def initialize (outputfile)
    self.source = open('http://www.dimdi.de/static/de/klassi/icd-10-gm/kodesuche/onlinefassungen/htmlgm2013/index.htm').read
    #self.source = Net::HTTP.get('dimdi.de','/static/de/klassi/icd-10-gm/kodesuche/onlinefassungen/htmlgm2013/index.htm')
    self.outputfile = File.open(File.dirname(__FILE__) + "/#{outputfile}", 'w')
    self.entrylist = []
  end

  def parse

    wholestring = ""
    source.each_line() do |line|
      wholestring<<line
    end
    lines = wholestring.split('<a')
    lines.each do |line|
      if line.match('[A-Z]\d\d-[A-Z]\d\d<\/a>')
        coderange = line.match('[A-Z]\d\d-[A-Z]\d\d<\/a>').to_s
        coderange.slice!('</a>')

        code_arr = coderange.split('-')
        code_first = code_arr.first
        code_last = code_arr.last


        title_raw = line.match('title="(.+)" ').to_s
        if title_raw.eql?("")
          title_raw = line.match('<td>.+</td>').to_s
          title_raw.slice!('<td>')
          title_raw.slice!('</td>')
          title = title_raw
        else
          title_arr = title_raw.split('"')
          title = title_arr[1]
        end
        entry = Entry.new(title, code_first, code_last)
        entrylist << entry
      end
    end
    self.set_levels
    self.write_entries
  end

end