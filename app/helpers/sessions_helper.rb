module SessionsHelper
 
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = user.id
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user?(user)
    user == current_user
  end
                 
  def deny_access
    store_location
    redirect_to signin_path, :notice => :please_sign_in
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin? || current_user.super_admin?
  end
  
  def super_admin_user
    redirect_to(root_path) unless current_user.super_admin?
  end  

  private

    def authenticate
      deny_access unless signed_in?
    end

    def user_from_remember_token
      User.find_by_id(cookies.signed[:remember_token]) 
    end       

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end
end
