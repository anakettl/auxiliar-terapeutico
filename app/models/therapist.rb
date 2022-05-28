class Therapist < ApplicationRecord
  belongs_to :user
  has_many :patients, dependent: :destroy
  has_many :exercises, dependent: :destroy

  accepts_nested_attributes_for :user
end
