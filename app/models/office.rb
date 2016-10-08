class OfficeSetup
  include Mongoid::Document
  include Mongoid::Timestamps

  #Office Information - General
  field :client_data_last_import, type: Time

  has_many :advisor
  has_many :client

end