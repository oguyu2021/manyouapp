class User < ApplicationRecord
  has_many :tasks
  before_destroy:admin_jump
  before_update:admin_jump
  
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true

  private

    def admin_jump
        throw(:abort) if self.admin == true && User.where(admin: true).count == 1
    end
end
