class AddCommentsToLogEntries < ActiveRecord::Migration
  def change
    add_column :log_entries, :comments, :text
  end
end
