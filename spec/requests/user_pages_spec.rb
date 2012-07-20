require 'spec_helper'

describe "UserPages" do
  subject {page}
  describe "Sign Up Page" do
    before {visit '/signin'}
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
    before {visit '/signin'}
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

end
