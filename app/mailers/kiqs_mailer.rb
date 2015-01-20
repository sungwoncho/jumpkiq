class KiqsMailer < ApplicationMailer
  default from: 'mailman@sidekiq.co'

  ADMIN_EMAIL = 'order@sidekiq.co'

  def new_order(kiq)
    @kiq = kiq
    @stylist = @kiq.stylist
    @user = @kiq.user

    stylist = @stylist.email
    subject = 'New order from #{@user.firstname}'

    mail to: stylist, cc: ADMIN_EMAIL, subject: subject
  end
end
