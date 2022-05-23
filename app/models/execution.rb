class Execution < ApplicationRecord
  belongs_to :realization
  belongs_to :exercise
  has_one :feedback

  has_one_attached :video
end
