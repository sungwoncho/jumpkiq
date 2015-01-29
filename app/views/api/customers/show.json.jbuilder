if @customer
  json.card do
    json.brand @customer.cards.data[0].brand
    json.last4 @customer.cards.data[0].last4
    json.exp_month @customer.cards.data[0].exp_month
    json.exp_year @customer.cards.data[0].exp_year
  end
end

json.exists @customer.present?
