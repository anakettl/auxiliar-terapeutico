class Frequency < ApplicationRecord
  belongs_to :exercise, dependent: :destroy
  belongs_to :training, dependent: :destroy
end
