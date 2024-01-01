class UserMailer < ApplicationMailer
    default from: 'noreply@example.com'
  
    def confirmation_email(user)
      @user = user
      @confirmation_url = confirm_email_url(token: @user.confirmation_token)
      mail(to: @user.email, subject: '이메일 인증')
    end
  end
  