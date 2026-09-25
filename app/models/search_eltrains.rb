class SearchEltrains
  include ActiveModel::Model
  include ActiveModel::Attributes

  belongs_to :rw_eltrains_route
  has_one :rw_route, through: :rw_eltrains_route
  belongs_to :rw_start_route, class_name: "Station", foreign_key: "start_route"
  belongs_to :rw_end_route, class_name: "Station", foreign_key: "end_route"


  # Define your virtual attributes
  attribute :eltrains_number, :integer
  attribute :station_start_id, :integer
  attribute :station_finish_id, :integer
  attribute :station_start_time, :time
  attribute :station_finish_time, :time

end
