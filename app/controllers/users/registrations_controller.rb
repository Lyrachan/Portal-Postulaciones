# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  # GET /resource/sign_up
  def new
    super do |resource|
      resource.images.build # Previamente estaba como resource.images.build, pero como el usuario sólo tiene una imagen, no lo requiere
    end
  end

  # POST /resource
   def create
     super do |resource|
      if resource.persisted?  # La línea .persisted? verifica si el usuario ha sido guardado en la base de datos
        UserMailer.with(user: @user).welcome_email.deliver_now  # No funcionará en este caso, porque el usuario lo estoy registrando
                                                                # con publications_controller.rb
      end
    end      
  end

  # GET /resource/edit
  # def edit
  #   super do |resource|
  #     resource.build_image_blob # unless resource.image.present? # Previamente estaba como resource.images.build, pero como el usuario sólo tiene una imagen, no lo requiere
  #   end
  # end

  # PUT /resource
  def update
    super do |resource|
      resource.images.build # Previamente estaba como resource.images.build, pero como el usuario sólo tiene una imagen, no lo requiere
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
