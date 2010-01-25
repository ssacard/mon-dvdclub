# == Schema Information
# Schema version: 20080708191716
#
# Table name: dvd_categories
#
#  id   :integer(11)     not null, primary key
#  name :string(255)
#

class DvdCategory < ActiveRecord::Base
  has_many :dvds
  validates_presence_of :name
end