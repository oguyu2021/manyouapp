class ChangeTasksStatusToInteger < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :status, :integer, using: "status::integer"
  end

  def down
    change_column :tasks, :status, :string
  end
end
