class BaseController < ApplicationController
  before_action :authenticate_user!
  layout :layout_by_role #select layout by user role (doctor or receptionist)

  def home
  end



  #select layout by user role (doctor or receptionist)
  def layout_by_role
    if current_user.is_doctor
      'doctor' 
    elsif !current_user.is_doctor
      'receptionist' 
    else
      'application' # Default layout for unauthenticated users
    end
  end

  # authenticate_and_authorize_user!
  # def authenticate_and_authorize_user
  #   authenticate_user!

  #   if current_user.is_doctor?
      
  #   elsif
  #   else


  # end
  
end
