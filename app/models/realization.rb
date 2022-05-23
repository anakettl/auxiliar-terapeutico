class Realization < ApplicationRecord
  belongs_to :training
  has_many :executions
  has_many :feedbacks, through: :executions

  def start_time
    self.date
  end
end
