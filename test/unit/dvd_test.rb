require File.dirname(__FILE__) + '/../test_helper'

class DvdTest < ActiveSupport::TestCase

  should_have_and_belong_to_many :actors
  should_have_and_belong_to_many :manufacturers
  should_have_and_belong_to_many :directors

  context "A DVD instance" do
    setup do
      @dvd = Dvd.new
    end

    should "not be valid without a title" do
	assert_equal @dvd.valid?, false
    end
  end

end
