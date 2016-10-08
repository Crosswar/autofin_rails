class Advisor
  include Mongoid::Document
  include Mongoid::Timestamps

  field :is_admin, type: Mongoid::Boolean, default: false

  field :advisor_code, type: String
  field :advisor_name, type: String
  field :advisor_email, type: String

  belongs_to :office
  has_many :client

end