# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Demo accounts for local development. The password is read from the environment so it is never committed:
#   SEED_USER_PASSWORD=... bin/rails db:seed
if (password = ENV["SEED_USER_PASSWORD"]).present?
  { "customer@example.com" => :customer, "agent@example.com" => :agent }.each do |email_address, role|
    User.find_or_create_by!(email_address: email_address) do |user|
      user.role = role
      user.password = password
    end
  end
end
