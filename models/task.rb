class Task 
  include Mongoid::Document
  #include Geocoder::Model::Mongoid

  field :name, type: String
  field :description, type: String
  field :status, type: String
  field :pickup_lat, type: Numeric
  field :pickup_lng, type: Numeric
  field :delivery_lat, type: Numeric
  field :delivery_lng, type: Numeric

  validates :name, presence: true
  validates :pickup_lat, presence: true
  validates :pickup_lng, presence: true
  validates :delivery_lat, presence: true
  validates :delivery_lng, presence: true

  #geocoded_by :pickup_lat, :pickup_lng
end