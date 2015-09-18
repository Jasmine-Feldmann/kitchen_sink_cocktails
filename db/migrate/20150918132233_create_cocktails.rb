class CreateCocktails < ActiveRecord::Migration
  def change
    create_table :cocktails do |t|
      t.string :name, null: false
      t.string :link, null: false

      t.timestamps null: false
    end
  end
end
