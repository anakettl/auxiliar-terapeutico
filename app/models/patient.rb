class Patient < ApplicationRecord
  belongs_to :user
  has_one :therapist

  accepts_nested_attributes_for :user

  has_one_attached :photo
end
