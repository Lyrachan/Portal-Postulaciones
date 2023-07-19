class ApplicationController < ActionController::Base
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :age, :description, :role, images_attributes: [:url,
        :context, :id]])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :age, :description, :role, images_attributes:
        [:url, :context, :id]])
    end
end
