class CustomActionGrid < GridPanel
js_method :on_show_details, <<-JS
  function(){
    var tmpl = new Ext.Template("<b>{0}</b>: {1}<br/>"), html = "";

    Ext.iterate(this.getSelectionModel().selected.first().data, function(key, value){
      html += tmpl.apply([key.humanize(), value]);
    }, this);

    Ext.Msg.show({
      title: "Details",
      width: 300,
      msg: html
    });
  }
JS

js_method :init_component, <<-JS
  function(){
    #{js_full_class_name}.superclass.initComponent.call(this);

    this.getSelectionModel().on('selectionchange', function(selModel){
      this.actions.showDetails.setDisabled(selModel.getCount() != 1);
    }, this);
  }
JS

action :show_details, :text => "Show details"

def default_bbar
  [:show_details.action, "-", *super]
end

def default_context_menu
  [:show_details.action, "-", *super]
end

end
