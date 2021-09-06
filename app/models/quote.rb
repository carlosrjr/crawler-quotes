class Quote
  include Mongoid::Document

  field :quote, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array

  # Garante que o quote não será duplicado.
  validates_uniqueness_of :quote
end