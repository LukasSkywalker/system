# encoding: UTF-8
require_relative 'db_adapter'
require 'parallel_each'

class MatcherInserter

  def initialize
    @icds = {}
    @fhms = {}
    @map ={'ologie' => '', 'opathie' => '', 'iatrie' => '', 'medizin' => '', 'enter' => '', 'exter' => '', 'ische' => '', 'ierte' => '', 'ative' => '', 'tion' => ' ', ' und '=> ' ', ' durch ' => ' ', 'krankheit' => '', 'endo' => '', 'chungen' => '', 'klassisch' => '', 'mato' => '', 'gesichert' => '', 'ologisch' => '', ' der '=> ' ', ' des '=>' ', ' am ' => ' ', ' an '=>' ', 'akut' => '', 'schwer' => '', 'sonstige' =>  '', 'opth' => '', 'nicht' => '', 'näher' => '', 'ohne' => '', 'angabe' =>'', ' mit '=> '', ' für '=>'', 'blindh' => 'blindhh', 'haut' => 'hautt', 'heit' => '', 'hiv' => 'hi-virus', 'behandlung' => '', 'lunge' => 'l{unge}', 'ungen' => '', 'erkrankung' => '', 'übertragbar' => '' }


    @db = DbAdapter.new('pse4.iam.unibe.ch', '27017')
  end

  def get_icd_and_fs_data
    puts "INITIALIZING....."
    icds = @db.get_icds
    @icds = {}
    icds.each do |icd|
      names = []
      names << icd['text']
      names.concat icd['synonyms']

      @icds[icd['code']] = names
    end
    fmhs = @db.get_fmhs
    @fmhs = {}
    fmhs.each do |fmh|
      @fmhs[fmh['code']] = fmh['de']
    end
  end

  def insert_data
    puts "STARTING...."
    chunk_size = 5000
    chunk = 0

    count = @db.get_data_count
    chunks = (count / chunk_size).to_i

    puts "================ DATA SIZE = #{count} ====================="
    puts "================ CHUNK SIZE = #{chunk_size} ====================="

    while chunk <= chunks
      puts "======================== NEW CHUNK #{chunk} / #{chunks} ========================="
      beg = Time.now
      rels = @db.get_icd_fs_rel.limit(chunk_size).skip(chunk*chunk_size)

      rels.p_each(18) do |rel|
        icd_code = rel['icd_code']
        icd_names = @icds[icd_code]
        fs_code = rel['fs_code']
        fs_name = @fmhs[fs_code.to_i]
        id = rel['_id']

        update_match_score(id, icd_names, fs_name)
      end
      puts "========= TOOK #{Time.now - beg} SECONDS ============"
      chunk += 1
    end
  end

  def update_match_score(id, icd_names, fs_name)
    fs_name = cmatch_prepare fs_name

    score = 0
    icd_names.each do |icd_name|
      score += sequence_matching(icd_name, fs_name)
    end

    @db.insert_updated_rel(id, score)
  end


  def cmatch_prepare(s)
    s.downcase!
    @map.each{|a,b| s.gsub!(a, b)}
    s
  end
  # returns the number of 5 matched consecutive character sequences
  def character_matching(first, second)
    i=0; j=4; p=0
    for j in 4..first.length()-1
      k=0; l=4
      for l in 4..second.length()-1
        x = first[i..j]
        y = second[k..l]
        if (x.eql? y) && (!x.include?(' '))
          p = p+1
        end
        k = k+1
        l = l+1
      end
      i = i+1
      j = j+1
    end

    if p > 0
      puts first
      puts second
    end
    return p
  end

  # returns the number of the longest matched character sequence
  def sequence_matching(first, second)
    x=0
    for j in 0..first.length()-1
      for kk in 0..second.length()-1
        i=j
        k = kk
        p=0
        b = false
        while first[i]==second[k] do
          if first[i] == ' ' then break end
          p = p+1
          i=i+1
          k=k+1
          #puts first[i]
          if k==second.length() || i == first.length()
          then break end
        end
        #puts ""
        if x<p then x=p end
      end
    end

    return x
  end

end