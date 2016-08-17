class CreateLogbook < ActiveRecord::Migration
  def change
    create_table :logbooks do |t|
      t.string :name
      t.integer :user_id
    end
  end
end
