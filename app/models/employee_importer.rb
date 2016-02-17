class EmployeeImporter

  def self.parse_json(source)
    return "Please provide a valid source" if source.blank?
    begin
      records = JSON.load(open(source))
    rescue Exception => e
      puts "Unable to fetch json from source. Error: #{e}"
    end
    
    records.shift # remove the header row
    records.each_with_index do |record, index|
      begin
        Employee.create(total_earnings: record["total_earnings"], title: record["title"])
      rescue Exception => e
        puts "Unable to parse record #{index}. Error: #{e}"
      end
    end
  end
end