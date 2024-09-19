require "application_system_test_case"

class UsersLoginsTest < ApplicationSystemTestCase
  test "existing user can login" do
    visit root_path
    click_on I18n.t("shared.navbar.login")
    fill_in User.human_attribute_name(:email), with: "jerry@example.com"
    fill_in User.human_attribute_name(:password), with: "wrong"
    click_button I18n.t("sessions.new.submit")

    assert_selector ".notification.is-danger",
      text: I18n.t("sessions.create.incorrect_details")

    fill_in User.human_attribute_name(:email), with: "jerry@example.com"
    fill_in User.human_attribute_name(:password), with: "password"
    click_button I18n.t("sessions.new.submit")

    assert_current_path root_path
    assert_selector ".notification",
      text: I18n.t("sessions.create.success")
    assert_selector ".navbar-dropdown", visible: false
    end
end
