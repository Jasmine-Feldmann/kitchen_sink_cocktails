module ApplicationHelper

	def num_ingredients(cocktail)
		cocktail.ingredients.count
	end

end
