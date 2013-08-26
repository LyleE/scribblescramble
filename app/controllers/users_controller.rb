class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  # GET /users/1
  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to current_user, alert: 'Who?'
    end
  end

  def index
    @users = User.order("rating DESC").select :username, :rating
    @scribbles = Scribble.
      joins(:user) . 
      joins(:scribble_type) .
      group(:name, :username) .
      order("scribbles.id DESC") . 
      limit(10) . 
      select :username, :name, :s3_key
  end

  # GET /register
  def new
    @user = User.new
    @button_text = "Register"
  end

  # GET /users/1/edit
  def edit
    if params[:id].to_i != current_user.id
      redirect_to edit_user_path(current_user), alert: 'Can\'t edit other people, bro'
    end
    @user = current_user
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
    if params[:id].to_i != current_user.id
      redirect_to current_user, alert: 'Can\'t edit other people, bro'
    end

    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to current_user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /users/1
  def destroy
    if params[:id].to_i != current_user.id
      redirect_to edit_user_path(current_user), alert: 'Can\'t delete other people bro!'
    end
    current_user.destroy
    respond_to do |format|
      format.html { redirect_to :register, notice: "User deleted forever!" }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
