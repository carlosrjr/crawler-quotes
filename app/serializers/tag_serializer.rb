class TagSerializer < ActiveModel::Serializer
  attributes :title, :register_date

  # Definindo formato iso8601 para a data de registro quando o serialize for chamado.
  def attributes(*args)
    attrib = super(*args)
    attrib[:register_date] = object.register_date.to_time.iso8601 unless object.register_date.blank?
    attrib
  end
end
