Rails.application.config.middleware.insert_before 0, Rack::Cors do

  #let's see what happens
  allow do
    origins "http://localhost:5173", "https://andrew-wulf-portfolio.com/", "https://twitter-clone-frontend-q1pw.onrender.com"
    resource "*", headers: :any, methods: [:get, :post, :patch, :put, :delete]
  end
end