class User < ActiveRecord::Base
  
  validates_uniqueness_of :email
  
  validates_uniqueness_of :phone_number
end
