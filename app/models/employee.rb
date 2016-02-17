class Employee < ActiveRecord::Base

  validates_presence_of :title, :total_earnings

  def self.average_salary(query)
    return "Please provide a valid string input", 0 if query.blank?
    employees = like_title(query)
    return "No positions found matching or similar to '#{query}'", 0 if employees.blank?

    return (employees.inject(0.0){ |sum, employee| sum + employee.total_earnings }.to_f / employees.size).round(2), employees.size
  end

  private

  def self.like_title(title)
    title.blank? ? [] : Employee.where("title ILIKE ?", "%#{title.downcase}%")
  end
end