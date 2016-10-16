class Finance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :advised_by, type: String
  field :code, type: String
  field :name, type: String
  field :dob, type: Date
  field :status, type: String
  field :email, type: String
  field :amount_invested, type: BigDecimal
  field :amount_unused, type: BigDecimal

  belongs_to :user

  scope :active, -> { where(status: "ATIVO")}
  scope :inactive, -> { where(status: "INATIVO")}
  scope :total_invested, -> { where(:amount_invested.gt => 0)}
  scope :total_unused, -> { where(:amount_unused.gt => 0)}

end