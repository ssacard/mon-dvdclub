# == Schema Information
# Schema version: 20080708191716
#
# Table name: roles
#
#  id                :integer(11)     not null, primary key
#  authorizable_type :string(100)
#  authorizable_id   :integer(10)
#  name              :string(100)
#  created_at        :datetime
#  updated_at        :datetime
#

class Role < ActiveRecord::Base
end