class Users::PasswordsController < ApplicationController
  before_action :authenticate_current_password

  def update
    @user.password = params.dig(:user, :password)

    if @user.save(context: :password_change)
      return redirect_to edit_profile_path, status: :see_other, flash: { success: t(".success") }
    end

    render "users/edit", status: :unprocessable_entity
  end

  private
    def authenticate_current_password
      @user = current_user
      current_password = params.dig(:user, :current_password)

      unless @user.authenticate(current_password)
        flash.now[:danger] = t(".incorrect_password")
        render "users/edit", status: :unprocessable_entity
      end
    end
end
