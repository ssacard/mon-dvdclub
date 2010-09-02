require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserDvdClub do
  
  describe "being associated with other models" do  
    it "should belong to user" do
      UserDvdClub.reflect_on_association(:user).should_not be_nil
    end
        it "should belong to dvd_club" do
      UserDvdClub.reflect_on_association(:dvd_club).should_not be_nil
    end
  end
  
  describe "being created" do
    fixtures :users
    before(:each) do
      @user_dvd_club = UserDvdClub.new({ :user => users(:quentin), :description => "quentin"  } )
    end
  
    it "should be valid" do
      puts @user_dvd_club.errors.inspect
      @user_dvd_club.should be_valid
    end    
  end

end
