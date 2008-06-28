class DvdFormat < ActiveRecord::Base
  has_many :dvds
  validates_presence_of :name
end
