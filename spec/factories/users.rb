require 'rack/test'
FactoryGirl.define do
	avatar_path   = File.join(Rails.root, '/spec/factories/avatar.png')
	avatar_object = Rack::Test::UploadedFile.new(avatar_path)

	factory :user do
		email                 { Faker::Internet.email }
		password              'secret'
		password_confirmation 'secret'

		factory :user_with_avatar do
			avatar {avatar_object}
		end
		
		factory :admin do
			admin  true
			avatar {avatar_object}
		end
	end

end
