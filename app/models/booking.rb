class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile
  has_one :feedback

end
