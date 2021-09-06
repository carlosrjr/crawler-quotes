class User
  include Mongoid::Document
  field :username, type: String
  field :password, type: String

  # Garante que o username não será duplicado.
  validates_uniqueness_of :username
end
