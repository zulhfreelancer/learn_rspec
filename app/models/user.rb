class User < ActiveRecord::Base
  has_secure_password
  mount_uploader :avatar, AvatarUploader
  validates_presence_of :avatar
  validates :email, presence: true, uniqueness: true

  def avatar_file_name
      avatar.url.split("/").last
  end
end
