class EmployeeImporter
  require 'open-uri'

  # parse employee data from the given source. Skip invalid records
  def self.parse_json(source)
    return "Please provide a valid source" if source.blank?

    begin
      records = JSON.load(open(source))
    rescue Exception => e
      raise "Unable to fetch json from source. Error: #{e}"
    end

    records.each_with_index do |record, index|
      begin
        Employee.create(total_earnings: record["total_earnings"].to_d, title: record["title"].to_s)
      rescue Exception => e
        puts "Unable to parse record #{index}. Error: #{e}"
      end
    end
  end
end