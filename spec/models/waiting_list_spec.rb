require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WaitingList do
  
  describe "being associated with other models" do  
    it "should belong to user" do
      WaitingList.reflect_on_association(:user).should_not be_nil
    end
    
    it "should belong to a dvd" do
      WaitingList.reflect_on_association(:dvd).should_not be_nil
    end
  end
  
  describe "being created" do
    before(:each) do
      @waiting_list = WaitingList.new
    end
  
    it "should be valid" do
      @waiting_list.should be_valid
    end    
  end

end
