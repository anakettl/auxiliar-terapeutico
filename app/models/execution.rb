class Execution < ApplicationRecord
  belongs_to :realization
  belongs_to :exercise
  has_one :feedback, dependent: :destroy

  has_one_attached :video

  validates :video,
            content_type: [:mp4],
            size: { less_than: 15.megabytes , message: 'O vídeo deve ter menos de 15MB.' }

  validates :comment, presence: true, if: -> { video.blank? }
end
