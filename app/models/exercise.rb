class Exercise < ApplicationRecord
  belongs_to :therapist
  has_many :trainings, through: :frequencies

  has_one_attached :video
end
