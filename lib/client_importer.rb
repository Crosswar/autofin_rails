require 'roo'
module ClientImporter
  def self.import(file)
    Client.delete_all
    spreadsheet = SpreadsheetLoader.open_spreadsheet(file)
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
end