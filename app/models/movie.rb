class Movie < ActiveRecord::Base
  # JORDANS ATTEMPT CODE
  
  def self.all_ratings
    return ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings_list)
    if ratings_list.length() < 1
      #return all movies that fit
      return where(true)
    else
      #return movies with rating in ratings_list
      return where(true)
    end
  end
  
  # END JORDANS CODE
end
