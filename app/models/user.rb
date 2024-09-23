class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum :role, { guess: 0, admin: 1, doctor: 2, nurse: 3 }
end
