# -*- encoding : utf-8 -*-
class PagesController < ApplicationController
  def home
    @title ="Дом"
  end

  def contact
    @title ="Contact"
  end

  def about
    @title ="About"
  end
end
