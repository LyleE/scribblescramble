class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]

  def new
    @user = User.new
  end
  
  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        format.html { redirect_back_or_to(:play, :notice => 'Login successful.') }
      else
        format.html { redirect_to(:login, :alert => "Login failed.") }
      end
    end
  end
    
  def destroy
    logout
    redirect_to(:login, :notice => 'Logged out!')
  end
end