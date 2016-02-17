require 'spec_helper'

describe Employee do

  let(:employee){ create :employee }


  describe ".average_salary" do

    it "raise error on no input" do
      expect(Employee.average_salary(nil)).to eq "Please provide a valid string input"
      expect(Employee.average_salary("")).to eq "Please provide a valid string input"
      expect(Employee.average_salary(" ")).to eq "Please provide a valid string input"
    end

    it "returns message if job type not found" do
      expect(Employee.average_salary("bad")).to eq "Job title matching or similar to 'bad' not found"
    end

    it "returns an average with one record match" do
      employee
      expect(Employee.average_salary("teacher")).to eq 5000.00 # default factory
    end

    it "returns an average with multiple employees" do
      employee
      create :employee, total_earnings: 400.30
      2.times{ create :employee, total_earnings: 2000.04 }
      expect(Employee.average_salary("teacher")).to eq 2350.09
    end

    it "reutns an average only considering jobs like the title" do
      employee
      create :employee, total_earnings: 2000.00
      create :employee, total_earnings: 4000.00, title: "janitor"
      expect(Employee.average_salary("teacher")).to eq 3500
    end

    it "returns an average on a similar title" do
      employee2 = create :employee, title: "Subsitute Teacher", total_earnings: 3.0
      expect(Employee.average_salary("teacher")).to eq 3.0
    end

    it "is not case sensitive and recognizes partials" do
      employee
      expect(Employee.average_salary("TEACHER")).to eq 5000.00
      expect(Employee.average_salary("EACHE")).to eq 5000.00
    end
  end
end