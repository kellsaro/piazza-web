class User < ApplicationRecord
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }

  has_secure_password

  has_many :membershios, dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :app_sessions

  before_validation :strip_extraneous_spaces

  def self.create_app_session(email:, password:)
    return nil unless user = User.find_by(email: email&.downcase)

    user.app_sessions.create if user.authenticate(password)
  end

  def authenticate_app_session(app_session_id:, app_session_token:)
    app_sessions.find(app_session_id).authenticate_token(app_session_token)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  private

    def strip_extraneous_spaces
      self.name = self.name&.strip
      self.email = self.email&.strip
    end
end
