require 'rails_helper'

describe User do
 
    it "should has one avatar" do
    	@user = create(:user_with_avatar)
        expect(@user.avatar_file_name).to eq('avatar.png')
        # next here, we remove everything inside /spec/support/uploads folder
        # by calling 'FileUtils.rm_rf' method inside spec_helper.rb
    end

    it "mocking external API service" do
    	VCR.use_cassette('stackoverflow') do
    		response = User.random
    		expect(response).to be_a(Fixnum)
    	end
    end

end
