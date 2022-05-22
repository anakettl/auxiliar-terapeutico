class Realization < ApplicationRecord
  belongs_to :training
  has_many :executions

  def start_time
    self.date
  end
end
