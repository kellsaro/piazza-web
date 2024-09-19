require "application_system_test_case"

module Mobile
  class MobileSystemTestCase < ApplicationSystemTestCase
    MOBILE_WINDOW_SIZE = [ 375, 667 ]

    setup do
      visit root_path
      current_window.resize_to(*MOBILE_WINDOW_SIZE)
    end

    teardown do
      current_window.resize_to(*ApplicationSystemTestCase::WINDOW_SIZE)
    end
  end
end
