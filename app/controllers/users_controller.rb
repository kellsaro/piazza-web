class UsersController < ApplicationController
  skip_authentication only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @organization = Organization.create(members: [ @user ])
      @app_session = @user.app_sessions.create
      log_in(@app_session)

      flash[:success] = t(".welcome", name: @user.name)
      return recede_or_redirect_to root_path, status: :see_other
    end

    render :new, status: :unprocessable_entity
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(update_params)
      return redirect_to edit_profile_path,
        status: :see_other,
        flash: { success: t(".success") }
    end

    render :edit, status: :unprocessable_entity
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def update_params
      params.require(:user).permit(:name, :email)
    end
end
