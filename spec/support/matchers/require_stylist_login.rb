RSpec::Matchers.define :require_stylist_login do |expected|
  match do |actual|
    expect(actual).to redirect_to Rails.application.routes.url_helpers.new_stylist_session_path
  end

  failure_message do |actual|
    "expected to require stylist login to access the method"
  end

  failure_message_when_negated do |actual|
    "expected not to require stylist login to access the method"
  end

  description do
    "redirect to the stylist login page"
  end
end
