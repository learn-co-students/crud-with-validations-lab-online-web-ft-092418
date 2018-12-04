class Song < ActiveRecord::Base
  validates :title, :artist_name, presence: true
  validates :released, inclusion: {in: [true, false]}
  #binding.pry
  validates :release_year, presence: true, if: -> {self.released?}
  validate :release_year_not_in_future, :release_year_not_repeated
  #validates :release_year, :numericality  => {less_than_or_equal_to: Time.current.year}

  def release_year_not_in_future
    if release_year.present? && release_year > Time.current.year
      errors.add(:release_year, "cant be in the future")
    end
  end

  def release_year_not_repeated
    #binding.pry
    song = Song.all.select {|song| song if song.artist_name == self.artist_name && song.title == song.title && self.release_year == song.release_year}
    if song.length > 0 && song[0] != self
      errors.add(:release_year, "cant release same song twice in one year")
    end
  end
end
