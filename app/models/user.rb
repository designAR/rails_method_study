class User < ApplicationRecord
    has_secure_password

    validates :name, presence: { message: "이름을 입력해주세요!" }
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
