class ApplicationController < ActionController::Base
    # before_action :configure_permitted_parameters, if: :devise_controller?  # Para ejecutar el método en todos los controladores, pero aquí se especifica para los controladores de devise

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :description, :role, images: []])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :age, :description, :role, images: []])
    end
end
