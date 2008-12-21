class Admin::UsersController < ApplicationController

  make_resourceful do
    actions :all

    response_for :create, :update do |format|
      format.html { redirect_to admin_users_path }
    end
  end

end
