class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/1
  def show
  end

  # GET /register
  def new
    @user = User.new
    @button_text = "Register"
  end

  # GET /users/1/edit
  def edit
    @button_text = "Save"
  end

  # POST /register
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        auto_login(@user)
        format.html { redirect_to( :play, notice: 'User was successfully created.') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :login }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
