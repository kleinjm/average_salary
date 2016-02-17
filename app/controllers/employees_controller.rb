class EmployeesController < ApplicationController

  def salary
    @title = query
    @average_salary, @records_count = Employee.average_salary(@title) if @title

    respond_to do |format|
      format.html
      format.json { render :json => @average_salary }
    end
  end

  private

  def query
    params[:title].to_s unless params[:title].blank?
  end
end