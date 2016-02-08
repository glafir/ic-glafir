class Airports < Application

  def configure(c)
    super
    c.title = "Airports"
    c.docked_items = [{
      xtype: :toolbar,
      dock: :left,
      items: [:do_som1, :do_som2]
    }]
    c.model = "Airport"
    c.columns = [
      {name: :iata_code, header: "Код IATA"},
      {name: :icao_code, header: "Код ICAO"},
      {name: :name_rus, header: "Наименование (RU)"},
#      {name: :name_eng, header: "Наименование (EN)"},
      {name: :city_rus, header: "Город (RU)"},
#      {name: :city_eng, header: "Город (EN)"},
      {name: :airport_state__name, header: "Статус"},
      {name: :airport_air_traffic__name, header: "Статус"},
      {name: :town__city_rus},
      {name: :weather_state, header: "В любьую погоду?"},
      {name: :iso_code, header: "Страна"},
#      {name: :latitude, header: "Широта"},
#      {name: :longitude, header: "Долгота"},
      {name: :actions, header: "Удалить?"}
    ]
  end
end


