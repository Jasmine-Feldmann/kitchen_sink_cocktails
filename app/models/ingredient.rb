class Ingredient < ActiveRecord::Base
	searchkick 
	has_many :cocktail_ingredients
	has_many :cocktails, through: :cocktail_ingredients
end
