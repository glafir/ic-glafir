class Aircompanies < Application
#component :tab_one # ...
#component :tab_two # ...
  def configure(c)
    super
    c.title = "aircompanies"
    c.model = "Aircompany"
    c.columns = [
      {name: :al_online_bulb,
        width: 30,
        header: "",
        label: "<div class='bulb-off' />",
        tooltip: "AL_online",
        getter: lambda { |r|
         bulb = r.al_online ? "on" : "off"
          "<div class='bulb-#{bulb}' />"
        }
      },
      {name: :iata_code, header: "Код IATA", width: 20},
      {name: :icao_code, header: "Код ICAO", width: 20},
#      {name: :image, :getter => lambda{ |r| "#{link_to image_tag(r.image,  height: '20'), r.id}" if r.image }},
      {name: :airline_name_rus, header: "Наименование (RU)"},
      {name: :airline_name_eng, header: "Наименование (EN)"},
      {name: :airport__name_rus, header: "Базовый аэропорт"},
      {name: :country__country_name, header: "Страна"},
      {name: :al_start, header: "Год основания"},
      {name: :al_finish, header: "Год прекращения"},
      {name: :actions, header: "Удвлить?"}
    ]
    c.tbar = [ {xtype: 'textfield', attr: :airline_name_rus, empty_text: 'search by name'}, :add, :edit, :apply, :delete, :search ]
  end
end
