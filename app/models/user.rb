class User < ApplicationRecord
  enum role: [ :default, :dean, :teacher, :registrar_head, :registrar_desk, :coordinator, :admin ]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :default
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable,
         :recoverable, :rememberable, :validatable


  validates :first_name, presence: true
  validates :father_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def full_name
    [first_name, father_name, last_name].join(' ')
  end
end
