class Application < Netzke::Grid::Base
include Netzke::Basepack::ActionColumn
#include Netzke::Grid::Base
plugin :grid_live_search do |c|
  c.klass = Netzke::Basepack::GridLiveSearch
end

client_styles do |c|
  c.require :main
end

client_class do |c|
  c.layout = :fit
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
    c.intro_html = "Click on a component in the navigation tree"
    c.items = [
      { layout: :border,
        tbar: [header_html, '->', :about],
        items: [
          { region: :west, item_id: :navigation, width: 300, split: true, xtype: :treepanel, root: menu, root_visible: false, border: false, title: "Navigation" },
          { region: :center, layout: :border, border: false, items: [
            { region: :north, height: 50, border: false, split: true, layout: :fit, items: [{item_id: :info_panel, padding: 5, border: false}] },
            { item_id: :main_panel, region: :center, layout: :fit, border: false,items: [{border: false, body_padding: 5, html: "Components will be loaded in thisarea"}] } # items is only needed here for cosmetic reasons (initial border)
          ]}
        ]
      }
    ]
    c.bbar = [ :add, :edit, :apply, :delete, :search, :paging]
    c.tbar = [ :add, :edit, :apply, :delete, :search, :paging]
    c.context_menu = [:show, :add, :edit, :delete, :apply, :search]
    c.paging = :pagination
    c.editing = :inline
  end

  component :airports do |c|
    c.desc = "Airports"
  end


protected

  def link(text, uri)
    "<a href='#{uri}'>#{text}</a>"
  end

  def header_html
    %Q{
      <div style="font-size: 150%;">
        <a href="http://ic.glafir.ru">IC-Glafir</a>
      </div>
    }
  end

  def leaf(text, component, icon = nil)
    { text: text,
      id: component,
      cmp: component,
      leaf: true
    }
  end


  def menu
    out = { 
      :text => "Navigation",
      :expanded => true,
      :children => [
        leaf("Countries", :countries),
        leaf("Towns", :towns),
        leaf("Airports", :airports),
        leaf("Airlines", :aircompanies)
        ]
      }
    out
  end
end
