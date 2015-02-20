class User < ActiveRecord::Base
  
  validates_uniqueness_of :email
  
  validates_uniqueness_of :phone_number
  
  def first_name=(s)
    write_attribute(:first_name, s.to_s.titleize) 
  end
  
  def last_name=(t)
    write_attribute(:last_name, t.to_s.titleize)
  end
  
  
  
end
