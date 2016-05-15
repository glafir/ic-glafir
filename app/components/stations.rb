class Stations < Application
  def configure(c)
    super
    c.title = "Stations"
    c.model = "Station"
    c.columns = [
      {name: :name_eng, header: "Название end"},
      {name: :name_rus, header: "Название rus"},
      {name: :station_zone__zone, header: "Зона"},
      {name: :station_type__typename, header: "Тип станции"}
    ]
  end
end

