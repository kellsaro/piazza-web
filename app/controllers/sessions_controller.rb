class SessionsController < ApplicationController
  skip_authentication only: [ :new, :create ]

  def new
  end

  def create
    @app_session = User.create_app_session(
      email: login_params[:email],
      password: login_params[:password]
    )

    if @app_session
      log_in(@app_session)

      flash[:success] = t(".success")
      return recede_or_redirect_to root_path, status: :see_other
    end

    flash.now[:danger] = t(".incorrect_details")
    render :new, status: :unprocessable_entity
  end

  def destroy
    log_out

    redirect_to root_path,
      status: :see_other,
      flash: { success: t(".success") }
  end

  private

  def login_params
    @login_params ||=
      params.require(:user).permit(:email, :password)
  end
end
