class Training < ApplicationRecord
  belongs_to :patient
  has_many :frequencies, dependent: :destroy
  has_many :exercises, through: :frequencies, dependent: :destroy
  has_many :realizations, dependent: :destroy

  def activate!
    self.active = true
    self.save!
  end
end
