class Task < ApplicationRecord
  belongs_to :user
  
  validates :name,  presence: true
  validates :description,  presence: true, length: { maximum: 50, message: 'Descriptionは550文字以内で入力してください'}
end
