class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :proposals
  has_many :videos, dependent: :destroy
  accepts_nested_attributes_for :videos, allow_destroy: true
  has_attached_file :profilepic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/profilepics/original/missing.png"
  validates_attachment_content_type :profilepic, :content_type => /\Aimage\/.*\Z/
  has_attached_file :coverphoto, :styles => { :medium => "840x300!", :small => "280x100!" }
  validates_attachment_content_type :coverphoto, :content_type => /\Aimage\/.*\Z/
  validates :category, presence: true
  validates :member, presence: true
  validates :profile_name, presence: true, length: { maximum: 50 }
  validates :bio, presence: true, length: { maximum: 50 }
  validates :location, presence: true
 
  filterrific(
    available_filters: [
      :category,
      :search_query
    ]
  )
self.per_page = 10
scope :category, lambda { |categories|
  where(category: [*categories  ])
}

scope :search_query, lambda { |query|
  # Searches the students table on the 'first_name' and 'last_name' columns.
  # Matches using LIKE, automatically appends '%' to each term.
  # LIKE is case INsensitive with MySQL, however it is case
  # sensitive with PostGreSQL. To make it work in both worlds,
  # we downcase everything.
  return nil  if query.blank?

  # condition query, parse into individual keywords
  terms = query.downcase.split(/\s+/)

  # replace "*" with "%" for wildcard searches,
  # append '%', remove duplicate '%'s
  terms = terms.map { |e|
    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
  }
  # configure number of OR conditions for provision
  # of interpolation arguments. Adjust this if you
  # change the number of OR conditions.
  num_or_conds = 2
  where(
    terms.map { |term|
      "(LOWER(profiles.location) LIKE ? OR LOWER(profiles.location) LIKE ?)"
    }.join(' AND '),
    *terms.map { |e| [e] * num_or_conds }.flatten
  )
}
 def self.options_for_select
    [
      ["DJ", "DJ"], 
      ["Singer", "Singer"], 
      ["Band", "Band"], 
      ["Magician", "Magician"], 
      ["Comic Artist", "Comic Artist"], 
      ["MC", "MC"]
    ]
  end

end
