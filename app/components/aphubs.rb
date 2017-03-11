class Aphubs < Application

  def configure(c)
    super
    c.title = "Aphubs"

    c.model = "Aphub"
    c.columns = [
      {name: :aircompany__airline_name_rus, header: "Авиакомпания"},
      {name: :airport__name_rus, header: "Аэропорт"},
      {name: :hub_type, header: "Статус"}
    ]
  end
end
