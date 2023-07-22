class UserMailer < ApplicationMailer
    default from: 'postulaciones@portal.com'

    def welcome_email
        @user = params[:user]
        # @url = 'http://example.com/login'
        mail(to: @user.email, subject: 'Te damos la bienvenida a Portal Postulaciones')
    end
end
