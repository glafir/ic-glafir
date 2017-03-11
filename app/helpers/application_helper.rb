module ApplicationHelper

  # Return a title on a per-page basis.

def time_spent_in_words seconds, params={}
  time_periods_shown = params[:time_periods_shown] || 3
  use_short_names = params[:use_short_names] || false
 
  return "0 seconds" if seconds < 1
  short_name = {:second => :sec, :minute => :min, :hour => :hr, :day => :day, :week => :wk, :year => :yr}
  [[60, :second], [60, :minute], [24, :hour], [7, :day], [52, :week], [1000, :year]].map{ |count, name|
    if seconds > 0
      seconds, n = seconds.divmod(count)
      name = short_name[name] if use_short_names
      "#{n.to_i} #{name}".pluralize(n.to_i) if n.to_i > 0
    end
  }.compact.last(time_periods_shown).reverse.join(' ')
end

  def title
    base_title = "Information Centre."
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

def twitterized_type(type)
 case type
    when :errors
      "alert-error"
    when :alert
      "alert-warning"
    when :error
      "alert-error"
    when :notice
      "alert-success"
    else
      "alert-info"
    end
  end
end
