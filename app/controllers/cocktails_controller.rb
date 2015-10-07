class CocktailsController < ApplicationController

def index
    if params[:query].present?
      @ingredients = Ingredient.search(params[:query], name: params[:name])
      @cocktails = @ingredients.map {|ingredient| ingredient.cocktails}.flatten!
    else
      @cocktails = Cocktail.all
    end
  end

end