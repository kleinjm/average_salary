require 'spec_helper'

describe EmployeesController do

  describe "#salary" do
    it "does nothing with no input" do
      get :salary
      expect(response.status).to eq 200
      expect(assigns(:title)).to eq nil
      expect(assigns(:records_count)).to eq 0
      expect(assigns(:average_salary)).to eq "Please provide a valid string input"
    end

    it "handles unexpected input without breaking" do
      get :salary, title: -555
      expect(response.status).to eq 200
      expect(assigns(:title)).to eq "-555"
      expect(assigns(:records_count)).to eq 0
      expect(assigns(:average_salary)).to eq "No positions found matching or similar to '-555'"
    end

    it "cannot find records with the given title" do
      get :salary, title: "teacher"
      expect(assigns(:title)).to eq "teacher"
      expect(assigns(:records_count)).to eq 0
      expect(assigns(:average_salary)).to eq "No positions found matching or similar to 'teacher'"
    end

    it "finds the given records" do
      create :employee, title: "janitor", total_earnings: 3000.00
      2.times{ create :employee }
      get :salary, title: "teacher"
      expect(assigns(:title)).to eq "teacher"
      expect(assigns(:records_count)).to eq 2
      expect(assigns(:average_salary)).to eq 5000.00
    end

    it "responds to json with no records" do
      xhr :get, :salary
      expect(response.status).to eq 200
      expect(assigns(:title)).to eq nil
      expect(assigns(:records_count)).to eq 0
      expect(assigns(:average_salary)).to eq "Please provide a valid string input"
    end

    it "responds to json with records" do
      create :employee
      xhr :get, :salary, title: "teacher"
      expect(response.status).to eq 200
      expect(assigns(:title)).to eq "teacher"
      expect(assigns(:records_count)).to eq 1
      expect(assigns(:average_salary)).to eq 5000.00
    end
  end
end