require 'rails_helper'

describe 'articles are easy to read' do
  it "is grouped by days, newest first" do
    [0, 10, 25, 60].each do |time_in_hours|
      FactoryGirl.create(:article, {
        title: ('article_at' + time_in_hours.to_s),
        posted_at: Time.now.beginning_of_day.advance(hours: time_in_hours)
      })
    end

    visit articles_path
    expect(page.all(:css, '.each_day').size).to eq 3
    expect(page.body).to match(/article_at60.*article_at25.*article_at10.*article_at0/m)
  end
end
