require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Admin::DvdFormatsController do
  describe "route generation" do

    it "should map { :controller => 'admin/dvd_formats', :action => 'index' } to /admin/dvd_formats" do
      route_for(:controller => "admin/dvd_formats", :action => "index").should == "/admin/dvd_formats"
    end
  
    it "should map { :controller => 'admin/dvd_formats', :action => 'new' } to /admin/dvd_formats/new" do
      route_for(:controller => "admin/dvd_formats", :action => "new").should == "/admin/dvd_formats/new"
    end
  
    it "should map { :controller => 'admin/dvd_formats', :action => 'show', :id => 1 } to /admin/dvd_formats/1" do
      route_for(:controller => "admin/dvd_formats", :action => "show", :id => 1).should == "/admin/dvd_formats/1"
    end
  
    it "should map { :controller => 'admin/dvd_formats', :action => 'edit', :id => 1 } to /admin/dvd_formats/1/edit" do
      route_for(:controller => "admin/dvd_formats", :action => "edit", :id => 1).should == "/admin/dvd_formats/1/edit"
    end
  
    it "should map { :controller => 'admin/dvd_formats', :action => 'update', :id => 1} to /admin/dvd_formats/1" do
      route_for(:controller => "admin/dvd_formats", :action => "update", :id => 1).should == "/admin/dvd_formats/1"
    end
  
    it "should map { :controller => 'admin/dvd_formats', :action => 'destroy', :id => 1} to /admin/dvd_formats/1" do
      route_for(:controller => "admin/dvd_formats", :action => "destroy", :id => 1).should == "/admin/dvd_formats/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'admin/dvd_formats', action => 'index' } from GET /admin/dvd_formats" do
      params_from(:get, "/admin/dvd_formats").should == {:controller => "admin/dvd_formats", :action => "index"}
    end
  
    it "should generate params { :controller => 'admin/dvd_formats', action => 'new' } from GET /admin/dvd_formats/new" do
      params_from(:get, "/admin/dvd_formats/new").should == {:controller => "admin/dvd_formats", :action => "new"}
    end
  
    it "should generate params { :controller => 'admin/dvd_formats', action => 'create' } from POST /admin/dvd_formats" do
      params_from(:post, "/admin/dvd_formats").should == {:controller => "admin/dvd_formats", :action => "create"}
    end
  
    it "should generate params { :controller => 'admin/dvd_formats', action => 'show', id => '1' } from GET /admin/dvd_formats/1" do
      params_from(:get, "/admin/dvd_formats/1").should == {:controller => "admin/dvd_formats", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'admin/dvd_formats', action => 'edit', id => '1' } from GET /admin/dvd_formats/1;edit" do
      params_from(:get, "/admin/dvd_formats/1/edit").should == {:controller => "admin/dvd_formats", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'admin/dvd_formats', action => 'update', id => '1' } from PUT /admin/dvd_formats/1" do
      params_from(:put, "/admin/dvd_formats/1").should == {:controller => "admin/dvd_formats", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'admin/dvd_formats', action => 'destroy', id => '1' } from DELETE /admin/dvd_formats/1" do
      params_from(:delete, "/admin/dvd_formats/1").should == {:controller => "admin/dvd_formats", :action => "destroy", :id => "1"}
    end
  end
end
