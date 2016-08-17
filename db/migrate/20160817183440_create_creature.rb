class CreateCreature < ActiveRecord::Migration
  def change
    create_table :creatures do |t|
      t.string :species
      t.float :length
      t.float :weight
      t.boolean :gamefish
      t.integer :log_entry_id
    end
  end
end
