# == Schema Information
# Schema version: 20080708191716
#
# Table name: manufacturers
#
#  id   :integer(11)     not null, primary key
#  name :string(255)     
#

class Manufacturer < ActiveRecord::Base
  validates_uniqueness_of :name
end
