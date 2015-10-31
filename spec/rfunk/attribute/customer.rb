class Customer
  include RFunk::Attribute

  attribute :title, String, default: 'Mr'
  attribute :first_name, String
  attribute :last_name, String
  attribute :options, Hamster::Hash, default: Hamster::Hash[name: 'Simon', gender: :male]
end
