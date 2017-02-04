require 'rails_helper'

describe User do
	it { have_one :avatar }
 
    it "should has one avatar" do
    	@user = create(:user_with_avatar)
        expect(@user.avatar_file_name).to eq('avatar.png')
        # next here, we remove everything inside /spec/support/uploads folder
        # by calling 'FileUtils.rm_rf' method inside spec_helper.rb
    end
end
