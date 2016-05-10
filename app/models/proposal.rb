class Proposal
  include ActiveModel::Model
  attr_accessor :name, :email, :telnum, :category, :event, :eventmore
  validates :name, :email, :category, :event, presence: true
  validates :telnum, presence: true, numericality: { only_integer: true }
end