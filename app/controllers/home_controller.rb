class HomeController < AuthenticatedController
  def index
    @dvds = self.current_user.dvds.select{|d| d.available?}  
  end
  
  def dvds
    @dvds = self.current_user.owned_dvds
  end
  
  def demands
    @dvds = self.current_user.dvds.select{ |d| d.approval? }
  end
end
