class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :register_date, type: DateTime
  
  # Garante que a tag não será duplicada.
  validates_uniqueness_of :title
end