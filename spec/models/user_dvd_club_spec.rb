require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserDvdClub do
  before(:each) do
    @user_dvd_club = UserDvdClub.new
  end

  it "should be valid" do
    @user_dvd_club.should be_valid
  end
end
