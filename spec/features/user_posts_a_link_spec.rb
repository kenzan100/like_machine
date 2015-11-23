require 'rails_helper'

describe "submit" do
  it "allows logged in user to post a ink" do
    article_link = 'http://myearth.ne.jp'
    article_title = 'Educational Trading Card Game "My Earth"'
    user = FactoryGirl.create(:user)
    page.set_rack_session(user_id: user.id)
    visit submit_path
    fill_in 'article_link', with: article_link
    fill_in 'article_title', with: article_title
    click_on 'submit'
    expect(page).to have_content article_title
  end
end
