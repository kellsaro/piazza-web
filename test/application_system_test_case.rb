require "test_helper"

# 'capybara' and 'capybara/cuprite' need to be defined for EvilSystems to work properly.
require "capybara"
require "capybara/cuprite"

require "evil_systems"

EvilSystems.initial_setup
# To pass in driver_options to cuprite you can do the following:
# EvilSystems.initial_setup(driver_options: { process_timeout: 20 })

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite

  include EvilSystems::Helpers
end
