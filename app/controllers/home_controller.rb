class HomeController < AuthenticatedController
  def index
    @dvds = self.current_user.dvds  
  end
  
  def me
    
  end
end
