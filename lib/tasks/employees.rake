namespace :employees do

  desc "Parse the json from the source into the db"
  task parse_json: :environment do
    begin
      Employee.parse_json(ENV["REPORT_SOURCE"])
    rescue Exception => e
      puts "Rake task failure: Unable to parse employees json. Error: #{e}"
    end
  end

end
