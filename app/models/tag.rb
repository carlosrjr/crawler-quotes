class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :register_date, type: DateTime
  
  validates_uniqueness_of :title
end