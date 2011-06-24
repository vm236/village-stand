require 'spec_helper'

describe Order do
  it { should belong_to :cart }
  it { should validate_presence_of :ship_address }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :zip }
  it { should validate_presence_of :telephone }
  it { should validate_presence_of :cc_number }

  describe 'creating new order should be displayed in last activites' do
    it "should increment lastactivity count by 2, because we creating user and order!" do
      expect { Factory(:order) }.to change { LastActivity.count }.by(2)
    end
  end
end
