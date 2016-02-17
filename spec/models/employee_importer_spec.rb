require "spec_helper"

describe EmployeeImporter do
  
  describe ".parse_json" do
    it "does nothing with no source" do
      expect(EmployeeImporter.parse_json("")).to eq "Please provide a valid source"
    end

    it "creates records from valid data" do
      # https://data.cityofboston.gov/resource/ntv7-hwjm.json

      # {'title':'Supvising Claims Agent (Asd)','total_earnings':'100381.19'},{'title':'Nurse Case Manager','total_earnings':'84167.21'}

      # stub_request(:get, /data.cityofboston.gov/).
      #   with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      #   to_return(status: 200, body: [{ name: "James" }], headers: {})

      stub_request(:get, "www.example.com").
        with(:body => {:data => {:a => '1', :b => 'five'}})

      uri = URI('www.example.com')

      response = Net::HTTP.get(uri)

      binding.pry

      # RestClient.post('www.example.com', "data[a]=1&data[b]=five",
      #   :content_type => 'application/x-www-form-urlencoded')    # ===> Success

      # uri = URI('https://data.cityofboston.gov/resource/ntv7-hwjm.json')
      # uri = URI('www.example.com')

      # response = Net::HTTP.get(uri)

      # expect(response).to be_an_instance_of(String)
    end
  end

  # def self.parse_json(source)
  #   records = JSON.load(open(source))
  #   records.shift # remove the header row
  #   records.each_with_index do |record, index|
  #     begin
  #       Employee.create(total_earnings: record["total_earnings"], title: record["title"])
  #     rescue Exception => e
  #       puts "Unable to parse record #{index}"
  #     end
  #   end
  # end

end