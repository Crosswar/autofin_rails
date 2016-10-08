class OfficeSetup
  include Mongoid::Document
  include Mongoid::Timestamps

  #Office information - Users
  field :office_admin, type: String
  field :office_admin_advisor_code, type: String

  #Office Information - General
  field :client_data_last_import, type: Time

  has_many :advisor
end