require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Admin::ClubTopicsController do
  describe "route generation" do

    it "should map { :controller => 'admin/club_topics', :action => 'index' } to /admin/club_topics" do
      route_for(:controller => "admin/club_topics", :action => "index").should == "/admin/club_topics"
    end
  
    it "should map { :controller => 'admin/club_topics', :action => 'new' } to /admin/club_topics/new" do
      route_for(:controller => "admin/club_topics", :action => "new").should == "/admin/club_topics/new"
    end
  
    it "should map { :controller => 'admin/club_topics', :action => 'show', :id => 1 } to /admin/club_topics/1" do
      route_for(:controller => "admin/club_topics", :action => "show", :id => 1).should == "/admin/club_topics/1"
    end
  
    it "should map { :controller => 'admin/club_topics', :action => 'edit', :id => 1 } to /admin/club_topics/1/edit" do
      route_for(:controller => "admin/club_topics", :action => "edit", :id => 1).should == "/admin/club_topics/1/edit"
    end
  
    it "should map { :controller => 'admin/club_topics', :action => 'update', :id => 1} to /admin/club_topics/1" do
      route_for(:controller => "admin/club_topics", :action => "update", :id => 1).should == "/admin/club_topics/1"
    end
  
    it "should map { :controller => 'admin/club_topics', :action => 'destroy', :id => 1} to /admin/club_topics/1" do
      route_for(:controller => "admin/club_topics", :action => "destroy", :id => 1).should == "/admin/club_topics/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'admin/club_topics', action => 'index' } from GET /admin/club_topics" do
      params_from(:get, "/admin/club_topics").should == {:controller => "admin/club_topics", :action => "index"}
    end
  
    it "should generate params { :controller => 'admin/club_topics', action => 'new' } from GET /admin/club_topics/new" do
      params_from(:get, "/admin/club_topics/new").should == {:controller => "admin/club_topics", :action => "new"}
    end
  
    it "should generate params { :controller => 'admin/club_topics', action => 'create' } from POST /admin/club_topics" do
      params_from(:post, "/admin/club_topics").should == {:controller => "admin/club_topics", :action => "create"}
    end
  
    it "should generate params { :controller => 'admin/club_topics', action => 'show', id => '1' } from GET /admin/club_topics/1" do
      params_from(:get, "/admin/club_topics/1").should == {:controller => "admin/club_topics", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'admin/club_topics', action => 'edit', id => '1' } from GET /admin/club_topics/1;edit" do
      params_from(:get, "/admin/club_topics/1/edit").should == {:controller => "admin/club_topics", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'admin/club_topics', action => 'update', id => '1' } from PUT /admin/club_topics/1" do
      params_from(:put, "/admin/club_topics/1").should == {:controller => "admin/club_topics", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'admin/club_topics', action => 'destroy', id => '1' } from DELETE /admin/club_topics/1" do
      params_from(:delete, "/admin/club_topics/1").should == {:controller => "admin/club_topics", :action => "destroy", :id => "1"}
    end
  end
end
