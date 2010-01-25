class Admin::UsersController < AdminController

  make_resourceful do
    actions :all

    response_for :create, :update do |format|
      format.html { redirect_to admin_users_path }
    end

    after :create, :update do
      if params[:active]
        @current_object.activate! unless @current_object.active?
      else
        @current_object.suspend! unless @current_object.suspended?
      end
    end

  end

end