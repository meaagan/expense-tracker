class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses, dependent: :destroy
  has_many :budgets, dependent: :destroy

  def current_budget
    budgets.where("period_start <= ?", Date.current.beginning_of_month).order(period_start: :desc).first
  end
end
