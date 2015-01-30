class Stylists::PagesController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_stylist
  before_action :set_kiq_count
  before_action :set_conversation_count

  def dashboard
  end

  private

    def set_stylist
      @stylist = current_stylist.decorate
    end

    def set_kiq_count
      @kiq_count = current_stylist.kiqs.count
    end

    def set_conversation_count
      @conversation_count = current_stylist.mailbox.conversations.count
    end
end
