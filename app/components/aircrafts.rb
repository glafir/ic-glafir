class Aircrafts < Netzke::Base
  def configure(c)
    super
    c.title = "Aircrafts"

    c.model = "Aircraft"
    c.columns = [
      {name: :aircraft_model, header: "Aircraft model"},
      {name: :aircraft_seats, header: "Aircraft seats"},
      {name: :aircraft_maxspeed, header: "Aircraft maxspeed"}
    ]
  end
end
