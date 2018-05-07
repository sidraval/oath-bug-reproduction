require "rails_helper"

feature "Bug reproduction example" do
  scenario "log in and visit pages" do
    visit new_session_path

    User.create(email: "foo@example.com", password_digest: "password")

    fill_in "user_email", with: "foo@example.com"
    fill_in "user_password", with: "password"

    click_button "Login"

    expect(page).to have_content "This page is a secret!"

    click_link "Click me"

    expect(page).to have_content "This is the index page,"
  end

  scenario "use oath helper to login in and visit pages" do
    user = User.create(email: "foo@example.com", password_digest: "password")
    sign_in(user)

    visit new_secret_path
    expect(page).to have_content "This page is a secret!"

    click_link "Click me"

    expect(page).to have_content "This is the index page,"
  end

  scenario "use oath helper to login in and visit pages without clicking" do
    user = User.create(email: "foo@example.com", password_digest: "password")
    sign_in(user)

    visit new_secret_path
    expect(page).to have_content "This page is a secret!"

    visit secrets_path

    expect(page).to have_content "This is the index page,"
  end
end
