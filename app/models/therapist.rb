class Therapist < ApplicationRecord
  belongs_to :user
  has_many :patients

  accepts_nested_attributes_for :user
end
