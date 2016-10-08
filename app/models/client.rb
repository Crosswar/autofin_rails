require 'roo'

class Client
  include Mongoid::Document
  include Mongoid::Timestamps

  field :client_advised_by, type: String
  field :client_code, type: String
  field :client_name, type: String
  field :client_dob, type: String
  field :client_email, type: String
  field :client_amount_invested, type: BigDecimal
  field :client_amount_unused, type: BigDecimal

  belongs_to :user

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      client = Client.new
      client.attributes = row.to_hash.slice(*row.to_hash.keys)
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