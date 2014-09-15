class Area < ActiveRecord::Base
  has_many :pois
  validates :name, uniqueness: true
end
