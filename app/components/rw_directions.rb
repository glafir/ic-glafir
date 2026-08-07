class RwDirections < Application
  def configure(c)
    super
    c.model = "RwDirection"
    c.columns = [
      {name: :station__name_rus, header: "Станции"},
      {name: :direction_station__name_rus, header: "Направление"}
    ]
  end
end
