class LogEntry < ActiveRecord::Base
  belongs_to :logbook
  has_many :creatures
end
