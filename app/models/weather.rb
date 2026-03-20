class Weather < ApplicationRecord
include ActiveModel::Validations
paginates_per 100
has_many :weather_states
belongs_to :airport, foreign_key: "place_id"
attr_accessor :created_at_short

  def created_at_short
    created_at.to_s(:short)
#    created_at.strftime("%d %b")
  end
end
