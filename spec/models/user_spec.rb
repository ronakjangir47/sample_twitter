require 'spec_helper'

describe User do
  before {@user = User.new(:name => "Test", :email => "example")}
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  describe "When name is Empty" do
    before {@user.name = "" }
    it { should_not be_valid }
  end
  puts @user
  describe "When email is Empty" do
    before {@user.email = "" }
    it { should_not be_valid }
  end
 
end
