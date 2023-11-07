class DoctorController < BaseController
    before_action :authorize_is_doctor!

    def graph
    end

    def all_patients
      @patients = Patient.all
    end



    def authorize_is_doctor!
        unless current_user.is_doctor?
          redirect_to root_path
        end
    end

end
