class Feedback < ApplicationRecord
  belongs_to :execution, dependent: :destroy
end
