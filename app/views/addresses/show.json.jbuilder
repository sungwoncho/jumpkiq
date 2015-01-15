if @address
  json.full_address @address.full_address
  json.extract! @address, :street_address, :secondary_address, :city, :state, :postcode
end

json.exists @address.present?
