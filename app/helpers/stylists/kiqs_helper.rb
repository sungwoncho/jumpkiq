module Stylists::KiqsHelper
  def kiq_nav(link_text, link_path, status = nil)
    class_name = @status == status ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end
end
