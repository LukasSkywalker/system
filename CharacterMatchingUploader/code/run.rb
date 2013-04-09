require_relative 'matcher_inserter'

matcher = MatcherInserter.new
matcher.get_icd_and_fs_data
matcher.insert_data