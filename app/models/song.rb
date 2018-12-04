class Song < ActiveRecord::Base
    validates :title, :artist_name, presence: true
    validates :title, uniqueness: { scope: [:release_year, :artist_name]}
    validates :released, inclusion: { in: [true, false] }
    with_options if: :released? do |s|
            s.validates :release_year, presence: true
            s.validates :release_year, inclusion: { in: 0..Time.now.year}
    end
    
    def released?
        released 
    end
end
