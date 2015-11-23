require 'rails_helper'

describe 'user can like a post' do
  it "allows a user to like a post" do
    FactoryGirl.create(:article)
    user = FactoryGirl.create(:user)
    page.set_rack_session(user_id: user.id)
    visit root_path
    click_on 'like'
    expect(page).to have_content '1 like'
  end
end
