class Logbook < ActiveRecord::Base
  belongs_to :user
  has_many :log_entries
end
