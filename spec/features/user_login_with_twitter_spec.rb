require 'rails_helper'

describe 'twitter login test' do
  # as with instructions in https://github.com/intridea/omniauth/wiki/Integration-Testing
  his_name = "anony"
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      uid: "123",
      provider: "twitter",
      info: {
        nickname: his_name
      }
    })
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end

  after do
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  describe "Social Login" do
    it "login and logout successfully" do
      visit root_path
      click_on "Sign in"
      expect(page).to have_content his_name
      click_on "Sign out"
      expect(page).to have_content "Sign in"
    end
  end
end
