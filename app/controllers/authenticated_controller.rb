# Other controllers, which needs authentication  inherit this controller

class AuthenticatedController < ApplicationController
  before_filter :login_required

end