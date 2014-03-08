class Customer
  include RFunk::Attribute

  attribute :title, String, default: 'Mr'
  attribute :first_name, String
  attribute :last_name, String
end
