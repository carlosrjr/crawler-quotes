class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :quote, :author, :about_author, :tags
end
