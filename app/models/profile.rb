class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # validates :photos, presence: true
  validates :category, presence: true
  validates :member, presence: true
  validates :profile_name, presence: true, length: { maximum: 50 }
  validates :bio, presence: true, length: { maximum: 50 }
  validates :location, presence: true
  validates :performance_fee, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def show_first_photo(size)
    if self.photos.length == 0
      "http://placehold.it/120x66"
    else
      self.photos[0].image.url(size)
    end
  end

  def average_rating
    if reviews.count == 0
      return 0
    else
      reviews.average(:star).round(2)
    end
  end

end
