class EmployeesController < ApplicationController

  def salary
    @average_salary = Employee.average_salary(query)
  end

  private

  def query
    params[:title].to_s unless params[:title].blank?
  end
end