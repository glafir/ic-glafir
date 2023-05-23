class StationZones < Application
  def configure(c)
    super
    c.title = "Station_zones"
    c.model = "StationZone"
    c.columns = [
      {name: :zone, header: "Зонв ствнции"},
    ]
  end
end

