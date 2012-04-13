class User < ActiveRecord::Base
  attr_accessible :dob, :email, :first_name, :last_name, :score
end
