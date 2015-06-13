class Timetableaps < Application
  def configure(c)
    super
    c.title = "Flights"
    c.model = "Timetableap"
    c.columns = [
      {name: :Flight_Number, header: "Номер рейса", width: 20},
      {name: :aircompany__airline_name_rus, header: "Авиакомпания", width: 150},
      {name: :airport__name_rus, header: "п. отпр", width: 150},
      {name: :apkey__airport__name_rus, header: "п.назнач", width: 150},
      {name: :TimeStart, time_format: "H:i",  header: "время отпр", width: 50},
      {name: :TimeEnd, format: "H:i", header: "время приб", width: 50}
    ]
  end
end
