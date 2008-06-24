require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DvdClub do
  
  describe "being associated with other models" do  
    it "should have many dvds" do
      DvdClub.reflect_on_association(:dvds).should_not be_nil
    end
    
    it "should belong to dvd_topic" do
      DvdClub.reflect_on_association(:club_topic).should_not be_nil
    end
    
    it "should have many user_dvd_clubs" do
      DvdClub.reflect_on_association(:user_dvd_clubs).should_not be_nil
    end
    
    it "should belong_to owner" do
      DvdClub.reflect_on_association(:owner).should_not be_nil
    end
  end
  
  describe "being created" do
    before(:each) do
      @dvd_category = DvdCategory.new
    end
  
    it "should not be valid" do
      @dvd_category.should_not be_valid
    end    
  end

end
