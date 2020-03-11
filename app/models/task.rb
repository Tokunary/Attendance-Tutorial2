class Task < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD
=======
  
  validates :name,presence: true
>>>>>>> task
end
