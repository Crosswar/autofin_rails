require 'roo'

class Client
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
  scope :total_unused, -> { where(:amount_unused.gt => 0)}

  def self.import(file)
    Client.delete_all
    spreadsheet = open_spreadsheet(file)
    spreadsheet.each_row_streaming(pad_cells: true, offset: 1) do |row|
      attributes = {
        :advised_by => row[0].try(:cell_value),
        :code => row[1].try(:cell_value),
        :name => row[3].try(:cell_value),
        :dob => row[11].try(:cell_value),
        :status => row[12].try(:cell_value),
        :email => row[7].try(:cell_value),
        :amount_invested => row[34].try(:cell_value),
        :amount_unused => row[38].try(:cell_value)
      }
      client = Client.new
      client.attributes = attributes
      client.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end