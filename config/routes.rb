Rails.application.routes.draw do

  get "/salary" => "employees#salary", as: "salary"

  root 'employees#salary'
end
