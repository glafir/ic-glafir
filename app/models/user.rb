class User < ActiveRecord::Base
include ActiveModel::Validations
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

#  has_and_belongs_to_many :roles
  has_many :flash_messages
  has_many :user_tracings
  belongs_to :user_theme
  belongs_to :town
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :traceable,
         :timeoutable,
#         :lastseenable,
         :encryptable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessor :login
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, :username, :time_zone, :town_id, :user_theme_id, :role
  validates :username,
    :uniqueness => {:case_sensitive => false}
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 70},
                    :uniqueness => {:case_sensitive => false },
                    :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  def set_default_role
    self.role ||= :user
  end

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
end

