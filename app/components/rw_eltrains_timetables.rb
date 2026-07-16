class RwRoutes < Application
  def configure(c)
    super
    c.title = "RW_routes"
    c.model = "RwRoute"
    c.columns = [
      {name: :rw_start_route__name_rus, header: "Начало маршрута"},
      {name: :rw_end_route__name_rus, header: "Конец маршрута"},
    ]
  end
end

