class Place < ActiveRecord::Base
  belongs_to :city, inverse_of: :places
  has_many :events
end
