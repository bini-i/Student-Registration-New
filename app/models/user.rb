class User < ApplicationRecord
  enum role: [ :default, :dean, :teacher, :registrar_head, :registrar_desk, :coordinator ]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :default
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
