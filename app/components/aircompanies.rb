class Aircompanies < Application
#component :tab_one # ...
#component :tab_two # ...
  def configure(c)
    super
    c.title = "Airlines"
    c.model = "Aircompany"
#    c.items = [
#      {component: :tab_one, title: "One"},
#      {component: :tab_two, title: "Two"}
#    ]
    c.columns = [
#      {name: :al_online_bulb,
#        width: 30,
#        header: "",
#        label: "<div class='bulb-off' />",
#        tooltip: "AL_online",
#        getter: lambda { |r|
#         bulb = r.al_online ? "on" : "off"
#          "<div class='bulb-#{bulb}' />"
#        }
#      },
      {name: :iata_code, header: "Код IATA", width: 50},
      {name: :icao_code, header: "Код ICAO", width: 50},
#      {name: :image, :getter => lambda{ |r| "#{link_to image_tag(r.image,  height: '20'), r.id}" if r.image }},
      {name: :airline_name_rus, header: "Наименование (RU)"},
      {name: :airline_name_eng, header: "Наименование (EN)"},
      {name: :airport__name_rus, header: "Базовый аэропорт"},
      {name: :al_start, format: "d-M-Y", header: "Дата основания"},
      {name: :al_finish, format: "d-M-Y", header: "Дата прекращения"},
      {name: :actions, header: "Удвлить?"}
    ]
  end
end
