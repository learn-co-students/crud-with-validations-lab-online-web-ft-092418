class ReleaseYearValidator < ActiveModel::Validator
  def validate(record)
    if record.released && record.release_year
      unless record.release_year < 2018
        record.errors.add(:release_year, "Invalid release_year")
      end
    elsif !record.released
      #do nothing
    else
      record.errors.add(:release_year, "Invalid release_year")
    end
  end
end

class Song < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: [ :release_year, :artist_name], message: "Only once per year per artist."}
  validates :released, inclusion: {in: [true, false]}
  validates_with ReleaseYearValidator
  validates :artist_name, presence: true

end
