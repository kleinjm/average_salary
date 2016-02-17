require 'spec_helper'

describe EmployeesController do

  describe "#salary" do
    it "does nothing with no input" do
      get :salary
      expect(response.status).to eq 200
      expect(assigns(:title)).to eq nil
      expect(assigns(:records_count)).to eq nil
      expect(assigns(:average_salary)).to eq nil
    end

    it "cannot find records with the given title" do
      get :salary, title: "teacher"
      expect(assigns(:title)).to eq "teacher"
      expect(assigns(:records_count)).to eq 0
      expect(assigns(:average_salary)).to eq "Job title matching or similar to 'teacher' not found"
    end

    it "finds the given records" do
      create :employee, title: "janitor", total_earnings: 3000.00
      2.times{ create :employee }
      get :salary, title: "teacher"
      expect(assigns(:title)).to eq "teacher"
      expect(assigns(:records_count)).to eq 2
      expect(assigns(:average_salary)).to eq 5000.00
    end
  end
end