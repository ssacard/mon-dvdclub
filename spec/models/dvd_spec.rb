require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dvd do
  
  describe "being associated with other models" do  
    it "should have many waiting_lists" do
      Dvd.reflect_on_association(:waiting_lists).should_not be_nil  
    end
    
    it "should have many manufacturers" do
      Dvd.reflect_on_association(:manufacturers).should_not be_nil  
    end
    
    it "should have many directors" do
      Dvd.reflect_on_association(:directors).should_not be_nil  
    end
    
    it "should belong to a dvd_category" do
      Dvd.reflect_on_association(:dvd_category).should_not be_nil  
    end
    
    it "should have many actors" do
      Dvd.reflect_on_association(:actors).should_not be_nil  
    end
    
    it "should belong to a format" do
      Dvd.reflect_on_association(:dvd_format).should_not be_nil  
    end
    
    it "should have a owner" do
      Dvd.reflect_on_association(:owner).should_not be_nil  
    end
  end
  
  describe "while created" do
    before(:each) do
      @dvd = Dvd.new
    end
    
    it "should not be valid" do
      @dvd.should_not be_valid
    end
  end
  
  describe "while treated as a state model" do
    
    before(:each) do
      @dvd = create_dvd
    end
    
    it "should be available by default" do
      @dvd.state.should == 'available'  
    end
    
    it "should move to approval state when requested" do
      @dvd.request!
      @dvd.state.should == 'approval'
    end
    
    it "should move to booked state when registered from approval state" do
      @dvd.request!
      @dvd.register!
      @dvd.state.should == 'booked'
    end
    
    it "should move to available state when the request is canceled" do
      @dvd.request!
      @dvd.cancel_request!
      @dvd.state.should == 'available'
    end
    
    it "should move to available state when unregistered from booked state" do
      @dvd.request!
      @dvd.register!
      @dvd.unregister!
      @dvd.state.should == 'available'
    end
  end
 
  private
  
  def valid_attributes
    {
      :title => 'test dvd'
    }
  end
  def create_dvd(options={})
    returning Dvd.new(valid_attributes.merge(options)) do |record|
      record.save
    end    
  end
end
