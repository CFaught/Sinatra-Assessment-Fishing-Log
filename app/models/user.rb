class User < ActiveRecord::Base
  has_secure_password
  has_many :logbooks
  has_many :log_entries, :through => :logbooks
  has_many :creatures, :through => :log_entries
end
