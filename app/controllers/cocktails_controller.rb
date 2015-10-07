class CocktailsController < ApplicationController

def index
  @cocktails = []
  hash = {}
  if params[:query2].present?
    ingredients1 = Ingredient.search(params[:query1], name: params[:name], order: {name: :asc}) 
    ingredients2 = Ingredient.search(params[:query2], name: params[:name], order: {name: :asc}) 
    cocktails = ingredients1.map {|ingredient| ingredient.cocktails}.flatten! 
    new_cocktails = ingredients2.map {|ingredient| ingredient.cocktails}.flatten! 
   	cocktails.each do |i| 
   		hash[i] = 1
   	end
   	new_cocktails.each do |j|
   		if hash.has_key?(j)
   			@cocktails << j
   		end
   	end
  elsif params[:query1].present?
  	@ingredients << Ingredient.search(params[:query1], name: params[:name], order: {name: :asc})
    @cocktails = @ingredients.map {|ingredient| ingredient.cocktails}
  else
    @cocktails = Cocktail.all
  end
end

end