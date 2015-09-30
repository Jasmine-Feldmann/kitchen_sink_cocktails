class CreateCocktailIngredients < ActiveRecord::Migration
  def change
    create_table :cocktail_ingredients do |t|
    	t.integer :cocktail_id, null: false
    	t.integer :ingredient_id, null: false
    	
      t.timestamps null: false
    end
  end
end
