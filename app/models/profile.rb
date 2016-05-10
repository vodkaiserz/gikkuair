class Profile < ActiveRecord::Base
include Filterable
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :proposals

  has_attached_file :profilepic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :profilepic, :content_type => /\Aimage\/.*\Z/
  # validates :photos, presence: true
  validates :category, presence: true
  validates :member, presence: true
  validates :profile_name, presence: true, length: { maximum: 50 }
  validates :bio, presence: true, length: { maximum: 50 }
  validates :location, presence: true
  validates :performance_fee, presence: true, numericality: { only_integer: true, greater_than: 0 }
  scope :category, -> (category) { where category: category }
  scope :location, -> (location) { where location: location }
  scope :starts_with, -> (profile_name) { where("profile_name like ?", "#{profile_name}%")}


end
