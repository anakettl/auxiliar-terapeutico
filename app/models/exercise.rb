class Exercise < ApplicationRecord
  belongs_to :therapist

  has_one_attached :video
end
