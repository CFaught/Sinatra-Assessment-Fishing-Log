class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password
  has_secure_password
  has_many :logbooks
  has_many :log_entries, :through => :logbooks
  has_many :creatures, :through => :log_entries
end
