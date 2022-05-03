class Therapist < ApplicationRecord
  belongs_to :user
  has_many :patients
  has_many :exercises

  accepts_nested_attributes_for :user
end
