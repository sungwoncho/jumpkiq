require "rails_helper"

RSpec.describe KiqsMailer, :type => :mailer do

  let(:stylist) { create(:stylist) }
  let(:kiq) { create(:kiq, stylist: stylist) }
  let(:admin_email) { 'order@sidekiq.co' }

  describe '.new_order' do

    before :each do
      KiqsMailer.new_order(kiq).deliver_now
    end

    it 'sends an email' do
      expect(ActionMailer::Base.deliveries.count).to eq 1
    end

    it 'sends the mail to the stylist of the kiq' do
      expect(ActionMailer::Base.deliveries.last.to).to include stylist.email
    end

    it 'sends the mail to the admin' do
      expect(ActionMailer::Base.deliveries.last.cc).to include admin_email
    end
  end
end
