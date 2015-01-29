json.(@user, :firstname, :lastname, :email,
              :height, :weight, :casual_shirt_size, :waist, :inseam,
              :long_sleeve_max_budget, :short_sleeve_max_budget, :polo_shirt_max_budget, :pants_max_budget, :shorts_max_budget,
              :long_sleeve, :short_sleeve, :polo_shirt, :pants, :shorts,
              :smart_style, :casual_style, :classic_style, :hipster_style,
              :stylist)

json.order do
  json.has_shipping_address @user.has_shipping_address?
  json.has_credit_card @user.has_credit_card?
  json.has_style @user.has_style?
  json.has_need @user.has_need?
  json.ready @user.ready_to_order?
  json.has_requested_kiq @user.requested_kiqs.present?
end
