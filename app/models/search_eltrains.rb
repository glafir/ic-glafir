class SearchEltrains
  include ActiveModel::Model
  include ActiveModel::Attributes

  # Define your virtual attributes
  attribute :eltrains_number, :integer
  attribute :rw_route_id, :integer
  attribute :station_start_id, :integer
  attribute :station_finish_id, :integer
  attribute :station_start_time, :time
  attribute :station_finish_time, :time

  # Симулируем связь belongs_to :rw_route
  def rw_route
    @rw_route ||= RwRoute.find_by(id: rw_route_id) if rw_route_id.present?
  end

  def rw_route=(obj)
    self.rw_route_id = obj&.id
    @rw_route = obj
  end
end
