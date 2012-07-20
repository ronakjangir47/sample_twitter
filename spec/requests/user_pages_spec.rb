require 'spec_helper'

describe "UserPages" do
  subject {page}
  describe "Sign Up Page" do
    before {visit '/signin'}
    it { should have_selector('title', :text => "Sample Twitter | Sign Up" ) }
    it { should have_content('Sample Twitter') }
  end
end
