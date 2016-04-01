class Timetableaps < Application
  attribute :TimeStart do |c|
    time_format = "%H:%M"
  end

  def configure(c)
    super
    c.title = "Flights"
    c.model = "Timetableap"
    c.columns = [
      {name: :flight, header: "рейс", width: 40},
      {name: :aircompany__airline_name_rus, header: "Авиакомпания", width: 130},
      {name: :airport_start__name_rus, header: "п. отпр", width: 100},
      {name: :airport_finish__name_rus, header: "п.назнач", width: 100},
      {name: :DateOfStartNav, header: "Старт навигации", width: 50},
      {name: :DateOfEndNav, header: "Конец навигации", width: 50},
      {name: :TimeStart, date_format: "%H:%M", header: "время отпр", width: 50},
      {name: :TimeEnd, date_format: "%H:%M", header: "время приб", width: 50}
    ]
  end
end
