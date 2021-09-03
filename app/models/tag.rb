class Tag
  include Mongoid::Document
  field :tag, type: String
 
  has_many :Quote
end
