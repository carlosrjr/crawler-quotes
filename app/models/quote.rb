class Quote
  include Mongoid::Document

  field :quote, type: String
  field :author, type: String
  field :about_author, type: String
  field :tags, type: Array

end
