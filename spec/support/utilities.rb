include ApplicationHelper

def valid_signin(user)
  fill_in "Email",    with: user.email.upcase # we upcase to make sure
                                                    # the ability to find the user
                                                    # in the db is case-insensitive
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end
