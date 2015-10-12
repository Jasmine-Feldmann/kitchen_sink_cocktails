class CocktailsController < ApplicationController

  def index
    @cocktails = []
    @ingredients = []
  end


  def show
    hash = {}
    @cocktails = []
    @ingredients = Ingredient.all.map {|ingredient| ingredient}
    @ingredients.select! {|ingredient| ingredient.name.downcase.include?(params[:query])}
    if params[:ingredients] 
      old_ingredients = []
      params[:ingredients].each do |ing|
        old_ingredients << Ingredient.find_by(name: ing)
      end
      cocktails = @ingredients.map {|ingredient| ingredient.cocktails }.flatten
      old_cocktails = old_ingredients.map {|ingredient| @cocktails << ingredient.cocktails }.flatten!
      old_cocktails.each do |cocktail|
        hash[cocktail] = 1
      end
      cocktails.each do |cocktail|
        if hash.has_key?(cocktail)
          @cocktails << cocktail
        end
      end
      @cocktails = @cocktails.uniq.flatten
    else
      @cocktails = @ingredients.map {|ingredient| ingredient.cocktails }.flatten
    end

  end


end