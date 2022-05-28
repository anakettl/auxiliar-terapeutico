class Realization < ApplicationRecord
  belongs_to :training
  has_many :executions, dependent: :destroy
  has_many :feedbacks, through: :executions, dependent: :destroy

  def start_time
    self.date
  end
end
