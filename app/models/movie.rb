class Movie < ActiveRecord::Base
  # JORDANS ATTEMPT CODE
  
  def self.all_ratings
    return ['G','PG','PG-13','R']
  end
  
  # END JORDANS CODE
end
