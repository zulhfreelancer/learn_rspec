class User < ActiveRecord::Base
  has_secure_password
  mount_uploader :avatar, AvatarUploader
  validates_presence_of :avatar
  validates :email, presence: true, uniqueness: true

  def avatar_file_name
      avatar.url.split("/").last
  end

  # not related to user
  # i just add this to learn how to use VCR gem - [zulh]
  def self.random
  	url = 'http://api.stackexchange.com/2.2/questions?site=stackoverflow'
  	res = HTTParty.get(url)
  	return res['quota_remaining']
  end
end
