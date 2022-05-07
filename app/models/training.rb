class Training < ApplicationRecord
  belongs_to :patient
  has_many :frequencies
  has_many :exercises, through: :frequencies

end
