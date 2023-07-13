class ChangeTasksPriorityToInteger < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :priority, :integer, using: "priority::integer"
  end

  def down
    change_column :tasks, :priority, :string
  end
end
