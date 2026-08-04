class RwEltrainsTimetables < Application
  def configure(c)
    super
    c.title = "Eltrains Timetables"
    c.model = "RwEltrainsTimetable"
    c.columns = [
      {name: :eltrains_number, header: "Номер Э/П"},
      {name: :station__name_rus, header: "Привязанный маршрут"},
      {name: :direction, header: "Направление"},
      {name: :time_start, header: "Вр приб."},
      {name: :time_finish, header: "Вр отпр."},
      {name: :rw_eltrains_route_id, header: "маршрут"},
      {name: :w1, header: "Пн"},
      {name: :w2, header: "Вт"},
      {name: :w3, header: "Ср"},
      {name: :w4, header: "Чт"},
      {name: :w5, header: "Пт"},
      {name: :w6, header: "Сб"},
      {name: :w0, header: "Вс"}
    ]
  end
end

