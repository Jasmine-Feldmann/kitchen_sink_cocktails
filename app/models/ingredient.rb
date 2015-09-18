class Ingredient < ActiveRecord::Base
	has_many :cocktail_ingredients
	has_many :cocktails, through: :ingredients
end
