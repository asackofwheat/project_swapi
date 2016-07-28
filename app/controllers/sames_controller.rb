class SamesController < ApplicationController

  def new
  end

  def create
    @name1 = params[:name1].upcase
    @name2 = params[:name2].upcase
    @results = Same.compare(params[:name1], params[:name2])
  end

end
