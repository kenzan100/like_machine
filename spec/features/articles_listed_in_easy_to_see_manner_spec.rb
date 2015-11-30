require 'rails_helper'

describe 'articles are easy to read' do
  it "is grouped by days, newest first" do
    [0, 10, 25, 60].each do |time_in_hours|
      FactoryGirl.create(:article, {
        title: ('article_at' + time_in_hours.to_s),
        posted_at: Time.zone.now.beginning_of_day.advance(hours: time_in_hours),
        posted_by: 1
      })
    end

    visit articles_path
    expect(page.all(:css, '.each_day').size).to eq 3
    expect(page.body).to match(/article_at60.*article_at25.*article_at0/m)
  end

  it "is orderd by highest like count within each day" do
    [[0, 1], [5, 2], [10, 0]].each do |time_in_hours, like_count|
      article = FactoryGirl.create(:article, {
        title: ('article_at' + time_in_hours.to_s),
        posted_at: Time.zone.now.beginning_of_day.advance(hours: time_in_hours),
        posted_by: 1
      })
      like_count.times do |i|
        user = FactoryGirl.create(:user)
        article.likes.create!(user_id: user.id, liked: true)
      end
    end

    visit articles_path
    expect(page.body).to match(/article_at5.*article_at0.*article_at10/m)
  end
end
