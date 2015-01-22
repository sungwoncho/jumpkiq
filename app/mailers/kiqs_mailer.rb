class KiqsMailer < ApplicationMailer
  default from: 'mailman@sidekiq.co'

  ADMIN_EMAIL = 'order@sidekiq.co'

  def new_order(kiq)
    @kiq = kiq
    @stylist = @kiq.stylist
    @user = @kiq.user

    stylist = @stylist.email
    subject = "New order from #{@user.firstname}"

    mail to: stylist, cc: ADMIN_EMAIL, subject: subject
  end

  def order_received(kiq)
    @kiq = kiq
    @user = @kiq.user

    user = @user.email
    subject = 'Thank you. Your order was received.'

    mail to: user, cc: ADMIN_EMAIL, subject: subject
  end
end
