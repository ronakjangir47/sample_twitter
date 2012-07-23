require 'spec_helper'

describe "UserPages" do
  subject {page}
  describe "Sign Up Page" do
    before {visit '/signup'}
    it { should have_selector('title', :text => "Sample Twitter | Sign Up" ) }
    it { should have_content('Sample Twitter') }
  end

  describe "Profile Page" do
    let(:user){ FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('title', text: "Sample Twitter | " + user.name)  }
    it { should have_selector('h1', text: user.name  ) }
  end

  describe "Test User creation" do
    before {visit '/signup'}
    let(:submit){"Create my account"}
    describe "with invalid details" do
      it { expect { click_button submit}.not_to change(User, :count) }
    end

    describe "with valid details" do
      before do
        fill_in "Name", with: "Rails Tutorails"
        fill_in "Email", with: "rails@tutorails.org"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it { expect {click_button submit}.to change(User, :count).by(1) }
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
      
    end
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all)  { User.delete_all }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "pagination" do

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete')}

      describe "with admin" do
        let(:admin) { FactoryGirl.create(:admin) }

        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it { should_not have_link('delete', href: user_path(admin)) }
        it "should be able to delete another user" do
          expect { click_link "delete" }.to change(User, :count).by(-1)
        end
      end
    end

  end
end
