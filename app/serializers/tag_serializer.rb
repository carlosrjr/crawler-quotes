class TagSerializer < ActiveModel::Serializer
  attributes :title, :register_date

  def attributes(*args)
    attrib = super(*args)
    attrib[:register_date] = object.register_date.to_time.iso8601 unless object.register_date.blank?
    attrib
  end
end
