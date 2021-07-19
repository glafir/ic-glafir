class Timetableaps < Application
  attribute :timeStart do |c|
    time_format = "%H:%M"
  end

  def configure(c)
    super
    c.title = "Flights"
    c.model = "Timetableap"
    c.columns = [
      {name: :flight_number, header: "рейс", width: 20},
      {name: :aircompany__airline_name_rus, header: "Авиакомпания", width: 80},
      {name: :parent__aircompany__airline_name_rus, header: "Parrent а/к", width: 80},
      {name: :airport_start__name_rus, header: "п. отпр", width: 80},
      {name: :airport_finish__name_rus, header: "п.назнач", width: 80},
      {name: :dateOfStartNav, header: "Старт навигации", width: 50},
      {name: :dateOfEndNav, header: "Конец навигации", width: 50},
      {name: :timeStart, date_format: "%H:%M", header: "время отпр", width: 50},
      {name: :timeEnd, date_format: "%H:%M", header: "время приб", width: 50}
    ]
  end
end
