class AircompanyTabPanel < Netzke::Basepack::TabPanel
  component :incomplete_tasks do |c|
    c.klass = Aircompanies
    c.title = "Действующие"
    c.scope = {done: [nil, false]}
  end

  component :completed_tasks do |c|
    c.klass = Aircompanies
    c.title = "Банкроты"
    c.scope = {done: true}
  end

  component :all_tasks do |c|
    c.klass = Aircompanies
    c.title = "Все"
    c.scope = nil
  end

  def configure(c)
    super
    c.items = [:incomplete_tasks, :completed_tasks, :all_tasks]
  end
end

