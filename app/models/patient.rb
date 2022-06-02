class Patient < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one :therapist, dependent: :destroy
  has_many :trainings, dependent: :destroy
  has_many :orientations, dependent: :destroy
  has_many :realizations, through: :trainings, dependent: :destroy

  accepts_nested_attributes_for :user

  has_one_attached :photo
end
