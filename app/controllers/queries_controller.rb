class QueriesController < ApplicationController

  def index
    @query = Query.all
  end

  def new
    @query = Query.new
  end

  def create
    @query = Query.new(get_params)
    @query.film = Swapi.get_films(@query.name)
    if Swapi.get_films(@query.name).nil?
      flash.notice = "Looks like that person doesn't exist.."
      redirect_to new_query_path
    else
      @query.name = Swapi.find_stat(@query.name, "name")
      @query.save
      flash.notice = "Check out your results!"
      redirect_to @query
    end
  end

  def show
    @query = Query.find(params[:id])
  end

  def destroy
    @query = Query.find(params[:id])
    @query.destroy
    flash.notice = "Query deleted!"
    redirect_to queries_path
  end

  def update
    @query = Query.find(params[:id])
    session[:fact] = Swapi.fun_fact(@query.name)
    redirect_to queries_path
  end

  private

  def get_params
    params.require(:query).permit(:name)
  end

end
