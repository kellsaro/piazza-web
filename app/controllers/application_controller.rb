class ApplicationController < ActionController::Base
  include Authenticate

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :turbo_frame_request?
end
