class User < ActiveRecord::Base
  has_many :likes
  has_many :articles, foreign_key: :posted_by

  def self.from_omniauth(auth_hash)
    where(auth_hash.slice("provider", "uid")).first \
      || create_from_omniauth(auth_hash)
  end

  def self.create_from_omniauth(auth_hash)
    create! do |user|
      user.provider = auth_hash["provider"]
      user.uid = auth_hash["uid"]
      user.username = auth_hash["info"]["nickname"]
    end
  end
end
