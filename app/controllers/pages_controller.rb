class PagesController < ApplicationController

  # momentarily just redirect to posts controller
  def index
    redirect_to controller: 'posts', action: 'index'
  end

end
