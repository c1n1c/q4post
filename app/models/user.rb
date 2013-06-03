class User < ActiveRecord::Base
  attr_accessible :name

  has_many :posts, :dependent => :destroy, :inverse_of => :user
end
