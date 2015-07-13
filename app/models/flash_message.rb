class FlashMessage < ActiveRecord::Base
  paginates_per 30
  belongs_to :user
end
