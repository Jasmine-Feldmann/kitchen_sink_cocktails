class CocktailsController < ApplicationController
  autocomplete :ingredient, :name

  def index
    @cocktails = []
    @ingredients = []
  end

  def autocomplete_ingredient_name
    @ingredients = Ingredient.order(:name).where("name LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @ingredients.map(&:name)
      }
    end
  end

  def show
    possible_cocktails = Hash.new(0)
    @ingredients = []
    @ingredients << Ingredient.find_by(name: params[:term])
    if params[:ingredients]
      params[:ingredients].each do |ing|
        @ingredients << Ingredient.find_by(name: ing)
      end
    end
    @ingredients.each do |ingredient|
      cocktails = ingredient.cocktails
      cocktails.each do |cocktail|
        possible_cocktails[cocktail] += 1
      end
    end
    length = @ingredients.length
    @cocktails = possible_cocktails.map{ |k,v| v == length ? k : nil }.compact
  end



end