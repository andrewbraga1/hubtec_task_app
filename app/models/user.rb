class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :password , confirmation: true, on: :create
  validates :password_confirmation , presence: true, on: :create
  has_many :tasks, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:trackable
  include DeviseTokenAuth::Concerns::User
end
