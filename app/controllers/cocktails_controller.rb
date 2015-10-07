class CocktailsController < ApplicationController

def index
  if params[:query1].present?
    @ingredients << Ingredient.search(params[:query1], name: params[:name], order: {name: :asc}) 
    @ingredients << Ingredient.search(params[:query2], name: params[:name], order: {name: :asc}) 
    @ingredients.flatten!
    cocktails = @ingredients.map {|ingredient| ingredient.cocktails}.flatten! 
    @ingredients.each do |c| puts c.name end
    @cocktails = cocktails.select { |cocktail| cocktails.count(cocktail) > 1}.uniq
  else
    @cocktails = Cocktail.all
  end
end

end