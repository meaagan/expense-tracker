class User < ApplicationRecord
    has_many :expenses
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true

    def full_name
        "#{first_name} #{last_name}"
    end
end
