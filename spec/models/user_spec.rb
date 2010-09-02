require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead.
# Then, you can remove it from this and the functional test.
include AuthenticatedTestHelper

describe User do
  fixtures :users

  describe "being associated with other models" do
    
    it "should have many waiting_lists" do
      User.reflect_on_association(:waiting_lists).should_not be_nil  
    end
    
    it "should have many user_dvd_clubs" do
      User.reflect_on_association(:user_dvd_clubs).should_not be_nil  
    end
    
    it "should have many dvd_clubs" do
      User.reflect_on_association(:dvd_clubs).should_not be_nil  
    end  
    
    it "should have many user_dvds" do
      User.reflect_on_association(:dvds).should_not be_nil  
    end
    
    it "should have many owned_dvd_clubs" do
      User.reflect_on_association(:owned_dvd_clubs).should_not be_nil  
    end
    
    it "should have many owned_dvds" do
      User.reflect_on_association(:owned_dvds).should_not be_nil  
    end
  end
  
  describe 'being created' do
    before do
      @user = nil
      @creating_user = lambda do
        @user = create_user
        violated "#{@user.errors.full_messages.to_sentence}" if @user.new_record?
      end
    end
    
    it 'increments User#count' do
      @creating_user.should change(User, :count).by(1)
    end
  end
  
  describe 'the dvds method for a user' do
    fixtures :users, :user_dvd_clubs, :dvd_clubs, :dvds, :dvd_categories
    before do
      @user = users(:quentin)
      dvd_category_1 = dvd_categories(:dvd_categories_001)
      dvd_category_2 = dvd_categories(:dvd_categories_002)
      user_dvd_club_1 = user_dvd_clubs(:user_dvd_clubs_001)
      user_dvd_club_2 = user_dvd_clubs(:user_dvd_clubs_002)
      dvd_club_1 = dvd_clubs(:dvd_clubs_001)
      dvd_club_2 = dvd_clubs(:dvd_clubs_002)
      dvd_1 = dvds(:dvds_001)
      dvd_2 = dvds(:dvds_002)
      dvd_3 = dvds(:dvds_003)
      dvd_4 = dvds(:dvds_004)
      @dvds = [dvd_1, dvd_2, dvd_3, dvd_4]
      @dvd_categories = [dvd_category_1, dvd_category_2]
      @user_dvd_clubs = [user_dvd_club_1, user_dvd_club_2]
      @dvd_clubs = [dvd_club_1, dvd_club_2]
    end
    
    it "should return the dvds belonging to his clubs" do
      @user.dvds.sort {|a,b| a.id <=> b.id }.should == [@dvds[0], @dvds[1]]      
    end
    
    it "should not return the dvds from the unsubscribed clubs" do
      @user.dvds.should_not == @dvds   
    end

### Not implemented / used
#    it "should return the dvd_categories of dvds belonging to his clubs" do
#      @user.dvd_categories.should == [@dvd_categories[0]]  
#    end
#    
#    it "should not return the dvd_categories of dvds from the unsubscribed clubs" do
#      @user.dvd_categories.should_not == @dvd_categories  
#    end
  end

  
  it 'requires login' do
    lambda do
      u = create_user(:login => nil)
      u.errors.on(:login).should_not be_nil
    end.should_not change(User, :count)
  end

  it 'requires password' do
    lambda do
      u = create_user(:password => nil)
      u.errors.on(:password).should_not be_nil
    end.should_not change(User, :count)
  end

  it 'requires password confirmation' do
    lambda do
      u = create_user(:password_confirmation => nil)
      u.errors.on(:password_confirmation).should_not be_nil
    end.should_not change(User, :count)
  end

  it 'requires email' do
    lambda do
      u = create_user(:email => nil)
      u.errors.on(:email).should_not be_nil
    end.should_not change(User, :count)
  end

  it 'resets password' do
    users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    User.authenticate('user', 'new password').should == users(:quentin)
  end

  it 'does not rehash password' do
    users(:quentin).update_attributes(:login => 'quentin2')
    User.authenticate('quentin2', 'password').should == users(:quentin)
  end

  it 'authenticates user' do
    User.authenticate('user', 'password').should == users(:quentin)
  end

  it 'sets remember token' do
    users(:quentin).remember_me
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).remember_token_expires_at.should_not be_nil
  end

  it 'unsets remember token' do
    users(:quentin).remember_me
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).forget_me
    users(:quentin).remember_token.should be_nil
  end

  it 'remembers me for one week' do
    before = 1.week.from_now.utc
    users(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).remember_token_expires_at.should_not be_nil
    users(:quentin).remember_token_expires_at.between?(before, after).should be_true
  end

  it 'remembers me until one week' do
    time = 1.week.from_now.utc
    users(:quentin).remember_me_until time
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).remember_token_expires_at.should_not be_nil
    users(:quentin).remember_token_expires_at.should == time
  end

  it 'remembers me default two weeks' do
    before = 2.weeks.from_now.utc
    users(:quentin).remember_me
    after = 2.weeks.from_now.utc
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).remember_token_expires_at.should_not be_nil
    users(:quentin).remember_token_expires_at.between?(before, after).should be_true
  end

protected
  def create_user(options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
    record.save
    record
  end
end
