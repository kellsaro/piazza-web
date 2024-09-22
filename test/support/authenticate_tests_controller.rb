require_relative "test_controller"

class AuthenticateTestsController < TestController
  include Authenticate

  skip_authentication only: [ :new, :create ]
  allow_unauthenticated only: [ :show ]

  helper_method :turbo_native_app?

  def show
    render plain: "User: #{Current.user&.id&.to_s}"
  end
end
