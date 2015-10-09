class CocktailsController < ApplicationController

def index
  @cocktails = []
  hash = {}
  if params[:query4].present?
  	temp1 = {}
  	temp2 = {}
    @ingredients = [params[:query1], params[:query2], params[:query3], params[:query4]]
    ingredients1 = Ingredient.search(params[:query1], name: params[:name], order: {name: :asc}) 
    ingredients2 = Ingredient.search(params[:query2], name: params[:name], order: {name: :asc}) 
    ingredients3 = Ingredient.search(params[:query3], name: params[:name], order: {name: :asc}) 
    ingredients4 = Ingredient.search(params[:query3], name: params[:name], order: {name: :asc}) 
    cocktails = ingredients1.map {|ingredient| ingredient.cocktails}.flatten! 
    new_cocktails = ingredients2.map {|ingredient| ingredient.cocktails}.flatten! 
    cocktails_3 = ingredients3.map {|ingredient| ingredient.cocktails}.flatten! 
    cocktails_4 = ingredients4.map {|ingredient| ingredient.cocktails}.flatten! 
   	cocktails.each do |i| 
   		hash[i] = 1
   	end
   	new_cocktails.each do |j|
   		if hash.has_key?(j)
   			temp1[j] = 1
   			cocktails_3.each do |k|
   				if temp1.has_key?(k)
   					temp2[k] = 1
   					cocktails_4.each do |l|
   						if temp2.has_key?(l)
   							@cocktails << l
   						end
   					end
   				end
   			end
   		end
   	end
   	@cocktails.uniq!
  elsif params[:query3].present?
  	temp = {}
    @ingredients = [params[:query1], params[:query2], params[:query3]]
    ingredients1 = Ingredient.search(params[:query1], name: params[:name], order: {name: :asc}) 
    ingredients2 = Ingredient.search(params[:query2], name: params[:name], order: {name: :asc}) 
    ingredients3 = Ingredient.search(params[:query3], name: params[:name], order: {name: :asc}) 
    cocktails = ingredients1.map {|ingredient| ingredient.cocktails}.flatten! 
    new_cocktails = ingredients2.map {|ingredient| ingredient.cocktails}.flatten! 
    cocktails_3 = ingredients3.map {|ingredient| ingredient.cocktails}.flatten! 
   	cocktails.each do |i| 
   		hash[i] = 1
   	end
   	new_cocktails.each do |j|
   		if hash.has_key?(j)
   			temp[j] = 1
   			cocktails_3.each do |k|
   				if temp.has_key?(k)
   					@cocktails << k
   				end
   			end
   		end
   	end
   	@cocktails.uniq!
  elsif params[:query2].present?
    @ingredients = [params[:query1], params[:query2]]
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
    @ingredients = [params[:query1]]
  	ingredients = Ingredient.search(params[:query1], name: params[:name], order: {name: :asc})
    @cocktails = ingredients.map {|ingredient| ingredient.cocktails}.flatten!
  else
    @cocktails = Cocktail.all
  end
end

end