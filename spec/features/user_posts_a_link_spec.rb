require 'rails_helper'

describe "submit" do
  it "allows logged in user to post a ink" do
    FactoryGirl.create(:user)
    visit submit_path
  end
end
