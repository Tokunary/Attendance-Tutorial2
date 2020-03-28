class Task < ApplicationRecord
  belongs_to :user
  
  validates :name,  presence: true
  validates :discription, length: { maximum: 50 }
end
