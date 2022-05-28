class Execution < ApplicationRecord
  belongs_to :realization
  belongs_to :exercise
  has_one :feedback, dependent: :destroy

  has_one_attached :video
end
