require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DvdsController do
  describe "route generation" do

    it "should map { :controller => 'dvds', :action => 'index' } to /dvd_clubs/1/dvds" do
      route_for(:controller => "dvds", :action => "index", :dvd_club_id => 1).should == "/dvd_clubs/1/dvds"
    end
  
    it "should map { :controller => 'dvds', :action => 'new' } to /dvd_clubs/1/dvds/new" do
      route_for(:controller => "dvds", :action => "new", :dvd_club_id => 1).should == "/dvd_clubs/1/dvds/new"
    end
  
    it "should map { :controller => 'dvds', :action => 'show', :id => 1 } to /dvd_clubs/1/dvds/1" do
      route_for(:controller => "dvds", :action => "show", :id => 1, :dvd_club_id => 1).should == "/dvd_clubs/1/dvds/1"
    end
  
    it "should map { :controller => 'dvds', :action => 'edit', :id => 1 } to /dvd_clubs/1/dvds/1/edit" do
      route_for(:controller => "dvds", :action => "edit", :id => 1, :dvd_club_id => 1).should == "/dvd_clubs/1/dvds/1/edit"
    end
  
    it "should map { :controller => 'dvds', :action => 'update', :id => 1} to /dvd_clubs/1/dvds/1" do
      route_for(:controller => "dvds", :action => "update", :id => 1, :dvd_club_id => 1).should == "/dvd_clubs/1/dvds/1"
    end
  
    it "should map { :controller => 'dvds', :action => 'destroy', :id => 1} to /dvd_clubs/1/dvds/1" do
      route_for(:controller => "dvds", :action => "destroy", :id => 1, :dvd_club_id => 1).should == "/dvd_clubs/1/dvds/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'dvds', action => 'index' } from GET /dvd_clubs/1/dvds" do
      params_from(:get, "/dvd_clubs/1/dvds").should == {:controller => "dvds", :action => "index", :dvd_club_id => "1"}
    end
  
    it "should generate params { :controller => 'dvds', action => 'new' } from GET /dvd_clubs/1/dvds/new" do
      params_from(:get, "/dvd_clubs/1/dvds/new").should == {:controller => "dvds", :action => "new", :dvd_club_id => "1"}
    end
  
    it "should generate params { :controller => 'dvds', action => 'create' } from POST /dvd_clubs/1/dvds" do
      params_from(:post, "/dvd_clubs/1/dvds").should == {:controller => "dvds", :action => "create", :dvd_club_id => "1"}
    end
  
    it "should generate params { :controller => 'dvds', action => 'show', id => '1' } from GET /dvd_clubs/1/dvds/1" do
      params_from(:get, "/dvd_clubs/1/dvds/1").should == {:controller => "dvds", :action => "show", :id => "1", :dvd_club_id => "1"}
    end
  
    it "should generate params { :controller => 'dvds', action => 'edit', id => '1' } from GET /dvd_clubs/1/dvds/1;edit" do
      params_from(:get, "/dvd_clubs/1/dvds/1/edit").should == {:controller => "dvds", :action => "edit", :id => "1", :dvd_club_id => "1"}
    end
  
    it "should generate params { :controller => 'dvds', action => 'update', id => '1' } from PUT /dvd_clubs/1/dvds/1" do
      params_from(:put, "/dvd_clubs/1/dvds/1").should == {:controller => "dvds", :action => "update", :id => "1", :dvd_club_id => "1"}
    end
  
    it "should generate params { :controller => 'dvds', action => 'destroy', id => '1' } from DELETE /dvd_clubs/1/dvds/1" do
      params_from(:delete, "/dvd_clubs/1/dvds/1").should == {:controller => "dvds", :action => "destroy", :id => "1", :dvd_club_id => "1"}
    end
  end
end
