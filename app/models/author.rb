class Author
  include Mongoid::Document
  field :titlte, type: String
  field :born, type: String
  field :description, type: String
  embedded_in :Quotes
end
