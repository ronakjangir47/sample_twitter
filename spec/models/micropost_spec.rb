require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }

  subject {@micropost}

  it { should respond_to(:content)}
  it { should respond_to(:user_id)}
  it { should respond_to(:user)}
  its(:user){ should == user}

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it {should_not be_valid}
  end

  describe "aceessible Attribute" do
    it "should not allow to access user id" do
      expect do
        Micropost.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when content is blank" do
    before { @micropost.content = "" }
    it { should_not be_valid}
  end

  describe "when micropost is too long" do
    before { @micropost.content = 'a'*141 }
    it { should_not be_valid}
  end

end
