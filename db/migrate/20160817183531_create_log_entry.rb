class CreateLogEntry < ActiveRecord::Migration
  def change
    create_table :log_entries do |t|
      t.string :location
      t.string :weather
      t.datetime :date
      t.string :moon_phase
      t.integer :logbook_id
    end
  end
end
