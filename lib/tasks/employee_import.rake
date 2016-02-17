namespace :employee_import do

  desc "Parse the json from the source into the db"
  task parse_json: :environment do
    begin
      EmployeeImporter.parse_json(ENV["SOURCE_URL"])
    rescue Exception => e
      puts "Rake task failure: Unable to parse employees json. Error: #{e}"
    end
  end

end
