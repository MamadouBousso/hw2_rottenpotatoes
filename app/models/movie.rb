class Movie < ActiveRecord::Base
  def self.Rate
    return ['G','PG','PG-13','R']
  end
end
