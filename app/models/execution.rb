class Execution < ApplicationRecord
  belongs_to :training
  belongs_to :exercise

  has_one_attached :video
end
