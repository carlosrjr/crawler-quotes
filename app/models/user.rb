class User
  include Mongoid::Document
  field :username, type: String
  field :password, type: String

  validates_uniqueness_of :username
end
