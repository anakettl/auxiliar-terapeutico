class Exercise < ApplicationRecord
  belongs_to :therapist
  has_many :trainings, through: :frequencies, dependent: :destroy
  has_many :frequencies, dependent: :destroy

  has_one_attached :video

  validates :video,
            content_type: [:mp4],
            size: { less_than: 15.megabytes , message: 'O vídeo deve ter menos de 15MB' }
end
