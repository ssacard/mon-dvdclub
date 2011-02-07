require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe UsersController do
  describe 'POST create' do
    before :each do
      User.delete_all
      DvdClub.delete_all
      Invitation.delete_all

      @valid_user_attrs = {
        :login => 'quire', 
        :email => 'quire@example.com',
        :email_confirmation => 'quire@example.com',
        :password => 'quire', 
        :password_confirmation => 'quire' 
      }

      @valid_dvdclub_attrs = {
        :name => 'Sample club'
      }
    end

    describe 'without invitation' do
      describe 'with valid user and dvd_club' do
        before :each do
          post 'create', :user => @valid_user_attrs, :dvd_club => @valid_dvdclub_attrs
        end
        it 'should create user' do
          User.count.should == 1
        end

        it 'should create dvd_club' do
          DvdClub.count.should == 1
        end

        it 'should associate user to dvd_club' do
          User.last.dvd_clubs.should include( DvdClub.last )
        end

        it 'should redirect to home page' do
          response.should redirect_to( home_url )
        end
      end

      describe 'with no password' do
        before :each do
          post 'create', :user => @valid_user_attrs.merge( :password => nil ), :dvd_club => @valid_dvdclub_attrs
        end

        it 'should not create user' do
          User.count.should == 0
        end

        it 'should not create dvd_club' do
          DvdClub.count.should == 0
        end

        it 'should render form' do
          response.should render_template( :new )
        end

        it 'should set error on password field' do
          assigns[ :user ].errors.on( :password ).should_not be_nil
        end
      end

      describe 'with no email' do
        before :each do
          post 'create', :user => @valid_user_attrs.merge( :email => nil ), :dvd_club => @valid_dvdclub_attrs
        end

        it 'should not create user' do
          User.count.should == 0
        end

        it 'should not create dvd_club' do
          DvdClub.count.should == 0
        end

        it 'should render form' do
          response.should render_template( :new )
        end

        it 'should set error on email field' do
          assigns[ :user ].errors.on( :email ).should_not be_nil
        end
      end

      describe 'with no dvd_club name' do
        before :each do
          post 'create', :user => @valid_user_attrs, :dvd_club => { :name => nil }
        end

        it 'should not create user' do
          User.count.should == 0
        end

        it 'should not create dvd_club' do
          DvdClub.count.should == 0
        end

        it 'should render form' do
          response.should render_template( :new )
        end

        it 'should set error on name field' do
          assigns[ :dvd_club ].errors.on( :name ).should_not be_nil
        end
      end
    end

    describe 'with invitation' do
      before :each do
        @user1 = User.create!  :login => 'test', :email => 'test@example.com', :email_confirmation => 'test@example.com', :password => 'test', :password_confirmation => 'test' 
        @dvd_club = DvdClub.create! :owner_id => @user1.id, :name => 'test_club'
        @assoc1 = UserDvdClub.create! :dvd_club_id => @dvd_club.id, :user_id => @user1.id
        @invitation = Invitation.create! :dvd_club_id => @dvd_club.id, :user_id => @user1.id, :token => 'test', :email => 'quire@example.com', :active => true
        post 'create', :user => @valid_user_attrs, :dvd_club => @valid_dvdclub_attrs, :token => @invitation.token
      end

      it 'should create user' do
        User.count.should == 2
      end

      it 'should not create new dvd club' do
        DvdClub.count.should == 1
      end

      it 'should associate user to dvd_club' do
        User.last.dvd_clubs.should include( @dvd_club )
      end

      it 'should redirect to home page' do
        response.should redirect_to( home_path )
      end
    end
  end
end
