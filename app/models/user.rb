class User
  attr_accessor :nameid, :attributes

  def initialize(nameid, attributes)
    @nameid = nameid
    @attributes = transform(attributes)
  end

  delegate :full_name, :role, :username, :email, to: :attributes

  def transform(attributes)
    OpenStruct.new(Hash[attributes.to_h.map { |key, values| [key.underscore, values[0]] }])
  end
end
