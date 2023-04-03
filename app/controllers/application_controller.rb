class ApplicationController < ActionController::Base#Actions
  # around_action :catch_exceptions
    # before_action :authenticate_user!
    # AUTHENTICATE_USER_EXCEPT_CONTROLLERS = ['main']

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end
    
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

    # def authenticate_user!
    #   unless AUTHENTICATE_USER_EXCEPT_CONTROLLERS.include?(params[:controller])
    #    super
    #   end
    # end

    protected
  
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
            user_params.permit( :user_type, :name, :email, :password, :password_confirmation)
        end
    end

    # def catch_exceptions
    #   yield
    #   rescue => exception
    #   if exception.is_a?(ActiveRecord::RecordNotFound)
    #     render 'errors/internal_server_error'
    #   else
    #     render 'errors/not_found'
    #   end
    # end

    private

        def remember_page
            session[:previous_pages] ||= []
            session[:previous_pages] << url_for(params.to_unsafe_h) if request.get?
            session[:previous_pages] = session[:previous_pages].uniq.first(2)
        end

end
