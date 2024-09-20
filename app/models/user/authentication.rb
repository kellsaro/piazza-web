module User::Authentication
  extend ActiveSupport::Concern

  included do
    validates :password,
      on: [ :create, :password_change ],
      presence: true,
      length: { minimum: 8 }

    has_secure_password
    has_many :app_sessions
  end

  class_methods do
    def create_app_session(email:, password:)
      return nil unless user = User.find_by(email: email&.downcase)

      user.app_sessions.create if user.authenticate(password)
    end
  end

  def authenticate_app_session(app_session_id:, app_session_token:)
    app_sessions.find(app_session_id).authenticate_token(app_session_token)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
