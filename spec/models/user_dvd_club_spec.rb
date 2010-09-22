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
      @user_dvd_club.should be_valid
    end    
  end

  describe "destroying" do
    fixtures :users, :dvds, :user_dvd_clubs
    before do
      @dvd = dvds(:dvds_001)
      @requester = users(:donald)
      @dvd.update_attributes!(:booked_by => @requester.id)
      @dvd.request!
    end
    it "should remove all pending requests if no other dvd club is shared" do
      Dvd.awaiting_approval.count.should == 1
      membership = user_dvd_clubs(:user_dvd_clubs_003)
      membership.destroy
      Dvd.awaiting_approval.count.should == 0
    end
    it "should remove all shared dvds if no other dvd club is shared" do
      @dvd.register!
      Dvd.booked.count.should == 1
      membership = user_dvd_clubs(:user_dvd_clubs_003)
      membership.destroy
      Dvd.booked.count.should == 0
    end
    it "should remove all pending requests from others if no other dvd club is shared" do
      Dvd.awaiting_approval.count.should == 1
      membership = user_dvd_clubs(:user_dvd_clubs_001)
      membership.destroy
      Dvd.awaiting_approval.count.should == 0
    end
    it "should remove all shared dvds with others if no other dvd club is shared" do
      @dvd.register!
      Dvd.booked.count.should == 1
      membership = user_dvd_clubs(:user_dvd_clubs_001)
      membership.destroy
      Dvd.booked.count.should == 0
    end
  end
end
