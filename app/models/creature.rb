class Creature < ActiveRecord::Base
  belongs_to :log_entry
end
