class Task < ApplicationRecord
  belongs_to : user
  validates :title, presence: true

  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }
  
  scope :title_search, -> (title) { where('title LIKE ?', "%#{title}%")}
  scope :status_search, -> (status) { where(status: status)}
  scope :sorted_by_deadline, -> { order(deadline: :asc) }
  scope :sorted_by_priority, -> { order(priority: :asc) }
end