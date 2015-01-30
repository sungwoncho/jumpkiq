class Stylists::PagesController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_stylist
  before_action :set_kiqs
  before_action :set_requested_kiqs
  before_action :set_conversation_count
  before_action :set_client_count

  def dashboard
  end

  private

    def set_stylist
      @stylist = current_stylist.decorate
    end

    def set_kiqs
      @kiqs = current_stylist.kiqs
    end

    def set_requested_kiqs
      @requested_kiqs = current_stylist.requested_kiqs
    end

    def set_conversation_count
      @conversation_count = current_stylist.mailbox.conversations.count
    end

    def set_client_count
      @client_count = current_stylist.users.count
    end
end
