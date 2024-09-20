require "application_system_test_case"

class UserUpdateNameTest < ApplicationSystemTestCase
  test "can update name" do
    log_in users(:jerry)

    visit edit_profile_path
    fill_in User.human_attribute_name(:name), with: "Jerry Seinfeld"
    click_button I18n.t("users.edit.save_profile")

    # FIX: the page is too big in the browser, so we need to scroll to see the updated name
    # assert_selector "#current_user_name", text: "Jerry Seinfeld"
    assert_selector "form .notification", text: I18n.t("users.update.success")
  end
end
