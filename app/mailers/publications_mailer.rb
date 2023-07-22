class PublicationsMailer < ApplicationMailer
    default from: 'postulaciones@portal.com'

    def postulate_user 
        @user = params[:user]
        @publication = params[:publication]
        # @url = 'http://example.com/login'
        mail(to: @user.email, subject: 'Hemos recibido tu postulación')
    end
end
