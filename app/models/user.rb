# encoding: UTF-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessor :login
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, :username, :time_zone
  validates :username,
    :uniqueness => {:case_sensitive => false}
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 70},
                    :uniqueness => {:case_sensitive => false },
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
end

