class Application < Netzke::Basepack::Grid
include Netzke::Basepack::ActionColumn
css_configure do |c|
  c.require :main
end


js_configure do |c|
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
  c.actions = [{name: :delete_row, icon: :delete}]
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
    c.bbar = [:add_in_form, :edit_in_form, :apply, :del, :search]
    c.tbar = [:add_in_form, :edit_in_form, :apply, :del, :search]
    c.context_menu = [:show, :add, :add_in_form, :edit_in_form, :del, :apply, :search]
  end
end
