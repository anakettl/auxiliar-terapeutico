class Patient < ApplicationRecord
  belongs_to :user
  has_one :therapist
  has_many :trainings
  has_many :realizations, through: :trainings

  accepts_nested_attributes_for :user

  has_one_attached :photo
end
