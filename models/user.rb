# Models
class User
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :role, type: String
  
end