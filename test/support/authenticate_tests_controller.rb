require_relative "test_controller"

class AuthenticateTestsController < TestController
  include Authenticate

  skip_authentication only: [ :new, :create ]
  allow_unauthenticated only: [ :show ]

  def show
    render plain: "User: #{Current.user&.id&.to_s}"
  end
end
