class Actor < ActiveRecord::Base
  has_and_belongs_to_many :dvds
 
  validates_uniqueness_of :name
end
