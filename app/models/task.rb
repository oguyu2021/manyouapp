class Task < ApplicationRecord
  validates :title, presence: true
  scope :sorted_by_deadline, -> { order(deadline: :asc) }
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }
  scope :sorted_by_priority, -> { order(priority: :asc) }
end