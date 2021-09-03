class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  
  validates_uniqueness_of :title
end
