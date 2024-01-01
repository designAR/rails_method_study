class User < ApplicationRecord
    has_secure_password

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	#emailを小文字に変換(メールアドレスは大文字・小文字を区別しないのでため
	before_save { self.email.downcase! }

	validates :name,  presence: false, length: { maximum: 50 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

    private
        def downcase_email
            self.email.downcase!
        end
end