class StylistDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def full_name
    "#{firstname} #{lastname}"
  end

end
