class Employee < ActiveRecord::Base

  validates_presence_of :title, :total_earnings

  def self.average_salary(query)
    return "Please provide a valid string input" if query.blank?
    employees = like_title(query)
    return "Job title matching or similar to '#{query}' not found" if employees.blank?
    return (employees.inject(0.0){ |sum, employee| sum + employee.total_earnings }.to_f / employees.size).round(2)
  end

  private

  def self.like_title(title)
    title.blank? ? [] : Employee.where("title ILIKE ?", "%#{title.downcase}%")
  end
end