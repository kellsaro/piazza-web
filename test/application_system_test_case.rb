require "test_helper"

# 'capybara' and 'capybara/cuprite' need to be defined for EvilSystems to work properly.
require "capybara"
require "capybara/cuprite"

require "evil_systems"

EvilSystems.initial_setup
# To pass in driver_options to cuprite you can do the following:
# EvilSystems.initial_setup(driver_options: { process_timeout: 20 })

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :evil_cuprite

  include EvilSystems::Helpers

  WINDOW_SIZE = [ 1400, 1400 ]

  private
    def log_in(user, password: "password")
      visit login_path
      fill_in User.human_attribute_name(:email), with: user.email
      fill_in User.human_attribute_name(:password), with: password
      click_button I18n.t("sessions.new.submit")

      assert_current_path root_path
    end
end
