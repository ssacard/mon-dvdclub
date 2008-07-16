# == Schema Information
# Schema version: 20080708191716
#
# Table name: directors
#
#  id   :integer(11)     not null, primary key
#  name :string(255)     
#

class Director < ActiveRecord::Base
  has_and_belongs_to_many :dvds

  validates_uniqueness_of :name
end
