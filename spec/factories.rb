FactoryGirl.define do
  factory :article do
    url 'http://myearth.ne.jp'
    title 'My Earth'
  end

  factory :user do
    uid "123"
    provider "twitter"
    username "anony"
  end
end
