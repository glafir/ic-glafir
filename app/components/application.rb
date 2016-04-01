class Application < Netzke::Grid::Base
include Netzke::Basepack::ActionColumn

plugin :grid_live_search do |c|
  c.klass = Netzke::Basepack::GridLiveSearch
end

client_styles do |c|
  c.require :main
end



client_class do |c|
  c.on_show = <<-JS
  function(){
    var tmpl = new Ext.Template("<b>{0}</b>: {1}<br/>"), html = "";

    Ext.iterate(this.getSelectionModel().selected.first().data, function(key, value){
      html += tmpl.apply([key.humanize(), value]);
    }, this);

    Ext.Msg.show({
      title: "Details",
      width: 400,
      height: 300,
      msg: html
    });
  }
  JS

  c.force_fit = true
  # handler for the 'delete' column action
  c.on_delete_row = <<-JS
    function(record){
    this.getSelectionModel().select(record);
    this.onDel();
    }
  JS

c.on_apply = <<-JS
  function() {
    Ext.Msg.confirm(this.i18n.confirmation,
      this.i18n.areYouSure, function(btn) {
      if (btn == 'yes') {
        this.getStore().sync();
      }
    }, this);
  }
JS
end

column :actions do |c|
  c.type = :action
  c.actions = [{name: :delete, icon: :delete}]
  c.header = ""
    c.width = 20
  end

action :show do |c|
  c.text = c.tooltip = "Show"
  c.icon = :report
  c.handler = :on_show
end


  def configure(c)
    super
    c.width = 1100
    c.height = 600
    c.persistence = true
    c.maximizable = true
    c.paging = true
    c.edit_inline = true
    c.bbar = [ :add, :edit, :apply, :delete, :search]
    c.tbar = [ :add, :edit, :apply, :delete, :search]
    c.context_menu = [:show, :add, :edit, :delete, :apply, :search]
  end
end
