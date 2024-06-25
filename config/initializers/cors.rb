Rails.application.config.middleware.insert_before 0, Rack::Cors do

  #let's see what happens
  allow do
    origins "http://localhost:5173"
    resource "*", headers: :any, methods: [:get, :post, :patch, :put, :delete]
  end
end