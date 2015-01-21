class KiqItem < ActiveRecord::Base
  belongs_to :kiq
  belongs_to :item
end
