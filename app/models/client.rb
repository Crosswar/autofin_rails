class Client
  include Mongoid::Document
  include Mongoid::Timestamps

  field :client_advised_by, type: String
  field :client_name, type: String
  field :client_dob, type: String
  field :client_email, type: String
  field :client_amount_invested, type: BigDecimal
  field :client_amount_unused, type: BigDecimal

  belongs_to :user

end