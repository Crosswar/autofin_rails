class Advisor
  include Mongoid::Document
  include Mongoid::Timestamps

  field :advisor_code, type: String
  field :advisor_name, type: String
  field :advisor_email, type: String

  has_many :client

end