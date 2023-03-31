class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    helper_method :is_manager?
    def is_manager?
      current_user && current_user.user_type == "Manager"
    end

    helper_method :is_qa?
    def is_qa?
      current_user && current_user.user_type == "QA"
    end

    helper_method :is_developer?
    def is_developer?
      current_user && current_user.user_type == "Developer"
    end

    protected
  
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
            user_params.permit( :user_type, :name, :email, :password, :password_confirmation)
        end
    end

    private

        def remember_page
            session[:previous_pages] ||= []
            session[:previous_pages] << url_for(params.to_unsafe_h) if request.get?
            session[:previous_pages] = session[:previous_pages].uniq.first(2)
        end

end
