class VinesController < ApplicationController
  require 'open-uri'
  def show
    url = "http://vine.co/v/#{params[:id]}"
    @html = open(url).read.html_safe
  end
end
