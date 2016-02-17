require "spec_helper"

describe EmployeeImporter do
  
  describe ".parse_json" do
    it "does nothing with no source" do
      expect(EmployeeImporter.parse_json("")).to eq "Please provide a valid source"
    end

    it "creates a record from valid data" do
      stub_request(:get, /data.cityofboston.gov/).
        to_return(status: 200, body: [{ title: "teacher", total_earnings: 200.00 }].to_json, headers: { content_type: "application/json" })

      expect{
        EmployeeImporter.parse_json("https://data.cityofboston.gov/resource/ntv7-hwjm.json")
        }.to change{Employee.count}.by(1)
      expect(Employee.first.title).to eq "teacher"
    end

    it "creates multiple valid records" do
          stub_request(:get, /data.cityofboston.gov/).
        to_return(status: 200, headers: { content_type: "application/json" }, body: [
          { title: "teacher", total_earnings: 200.00 },
          { title: "director", total_earnings: 4000000 },
          { title: "teacher" },
          { title: "" },
          { total_earnings: 300000 }
          ].to_json)

      expect{
        EmployeeImporter.parse_json("https://data.cityofboston.gov/resource/ntv7-hwjm.json")
        }.to change{Employee.count}.by(2)
    end

  end
end