class Song < ActiveRecord::Base
  validates :title , presence: true
  validates :artist_name , presence: true
  validates :title , uniqueness: {scope: [:release_year , :artist_name]}
  validates :release_year , numericality: {less_than_or_equal_to: 2016} , if: :released
  validates :release_year , presence: true , if: :released
end
