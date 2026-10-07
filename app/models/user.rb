class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  enum :role, { customer: "customer", agent: "agent" }, default: :customer, validate: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
