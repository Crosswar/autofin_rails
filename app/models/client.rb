require 'roo'

class Client
  include Mongoid::Document
  include Mongoid::Timestamps

  field :client_advised_by, type: String
  field :client_code, type: String
  field :client_name, type: String
  field :client_dob, type: Date
  field :client_email, type: String
  field :client_amount_invested, type: BigDecimal
  field :client_amount_unused, type: BigDecimal

  belongs_to :user

  def self.import(file)
    Client.delete_all
    spreadsheet = open_spreadsheet(file)
    spreadsheet.each_row_streaming(pad_cells: true, offset: 1) do |row|
      attributes = {
        :client_advised_by => row(0).try(:cell_value),
        :client_code => row[1].try(:cell_value),
        :client_name => row[3].try(:cell_value),
        :client_dob => row[11].try(:cell_value),
        :client_email => row[7].try(:cell_value),
        :client_amount_invested => row[34].try(:cell_value),
        :client_amount_unused => row[38].try(:cell_value)
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