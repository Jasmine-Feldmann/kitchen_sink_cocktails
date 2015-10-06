class Cocktail < ActiveRecord::Base
	searchkick
	has_many :cocktail_ingredients
	has_many :ingredients, through: :cocktail_ingredients
end
