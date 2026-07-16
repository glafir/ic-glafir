class RwEltrainsRoutes < Application
  def configure(c)
    super
    c.model = "RwEltrainsRoute"
    c.columns = [
      {name: :station__name_rus, header: "Начало маршрута"},
      {name: :priority_direct, header: "Приоритет"},
      {name: :number, header: "Номер маршрута"}
    ]
  end
end
