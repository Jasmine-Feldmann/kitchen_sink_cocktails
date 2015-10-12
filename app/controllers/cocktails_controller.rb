class CocktailsController < ApplicationController

  def index
    @cocktails = []
    @ingredients = []
  end

  def show
    @cocktails = []
    @ingredients = Ingredient.all.map {|ingredient| ingredient}
    @ingredients.select! {|ingredient| ingredient.name.downcase.include?(params[:query])}
    @ingredients.each {|ingredient| @cocktails << ingredient.cocktails }.flatten!
    @cocktails = @cocktails.uniq.flatten
  end


end