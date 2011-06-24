require 'spec_helper'

describe User do
  it { should have_many :carts }
  it { should have_many :votes }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :username }
  describe 'validate uniqueness of email and username' do
    subject {
      Factory.create(:user)
      }
    it { should validate_uniqueness_of :username }
    it { should validate_uniqueness_of :email }
  end

  describe 'creating new user should be displayed in last activites' do
    it "should increment lastactivity count by 1" do
      expect { Factory(:user) }.to change { LastActivity.count }.by(1)
    end
  end

  describe 'creating new user should be displayed in last activites' do
    it "should not increment lastactivity count by 2" do
      expect { Factory(:user) }.to_not change { LastActivity.count }.by(2)
    end
  end
end
