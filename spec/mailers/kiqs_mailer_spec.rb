require "rails_helper"

RSpec.describe KiqsMailer, :type => :mailer do

  let(:stylist) { create(:stylist) }
  let(:user) { create(:user) }
  let(:kiq) { create(:kiq, stylist: stylist, user: user) }
  let(:admin_email) { 'order@sidekiq.co' }

  describe '.new_order' do

    before :each do
      KiqsMailer.new_order(kiq).deliver_now
    end

    it 'sends an email' do
      expect {
        KiqsMailer.new_order(kiq).deliver_now
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends the mail to the stylist of the kiq' do
      expect(ActionMailer::Base.deliveries.last.to).to include stylist.email
    end

    it 'sends the mail to the admin' do
      expect(ActionMailer::Base.deliveries.last.cc).to include admin_email
    end
  end

  describe '.order_received' do

    before :each do
      KiqsMailer.order_received(kiq).deliver_now
    end

    it 'sends an email' do
      expect(ActionMailer::Base.deliveries.count).to eq 1
    end

    it 'sends the email to the user that ordered the kiq' do
      expect(ActionMailer::Base.deliveries.last.to).to include user.email
    end

    it 'sends the mail to the admin' do
      expect(ActionMailer::Base.deliveries.last.cc).to include admin_email
    end
  end
end
