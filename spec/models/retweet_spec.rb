require 'spec_helper'

describe Retweet do
  let(:user) { FactoryGirl.create(:user) }
  let(:micropost) { user.microposts.build(content: "lora", user_id: user.id ) }
  before { @retweet = user.retweets.build(micropost_id: micropost.id) }
  subject { @retweet }

  it { should respond_to(:user_id) }
  it { should respond_to{:micropost_id}}
  it { should respond_to(:retweet!) }

end
