require'rails_helper'

describe UsersController do
      before(:each) {set_user_session(create(:admin))}

      describe "POST #create" do
          it "uploads an avatar" do
              post :create, user: attributes_for(:user_with_avatar)
              expect(assigns(:user).avatar_file_name).to eq('avatar.png')
          end
      end

end
