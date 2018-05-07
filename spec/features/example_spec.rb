require "rails_helper"

feature "Bug reproduction example" do
  scenario "Signing in through the form works correctly" do
    visit new_session_path

    User.create(email: "foo@example.com", password_digest: "password")

    fill_in "user_email", with: "foo@example.com"
    fill_in "user_password", with: "password"

    click_button "Login"

    expect(page).to have_content "This page is a secret!"

    click_link "Click me"

    expect(page).to have_content "This is the index page,"
  end

  scenario "Using the sign_in oath helper doesn't persist session after link click" do
    user = User.create(email: "foo@example.com", password_digest: "password")
    sign_in(user)

    visit new_secret_path
    expect(page).to have_content "This page is a secret!"

    click_link "Click me"

    expect(page).to have_content "This is the index page,"
  end
end
