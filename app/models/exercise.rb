class Exercise < ApplicationRecord
  belongs_to :therapist
  has_many :trainings, through: :frequencies, dependent: :destroy
  has_many :frequencies, dependent: :destroy

  has_one_attached :video
end
