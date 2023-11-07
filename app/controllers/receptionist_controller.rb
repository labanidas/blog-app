class ReceptionistController < BaseController
    before_action :authorize_is_doctor!
    
    def see_all_patients
        @patients = Patient.all
    end

    def new_patient        
        @patient = Patient.new
        @action = "new_patient"
    end

    def add_patient
        @patient = Patient.new(
            name: params[:name],
            email: params[:email],
            number: params[:number],
            birthdate: params[:birthdate]
        )

        if @patient.save 
            p "***************************************"
            p "******* patient saved************"
            p "***************************************"
            flash[:notice] = "Patient created"
            redirect_to action: "see_all_patients"
          else
            flash[:alert] = "Patient not saved, Please try again later"
            redirect_to action: "new_patient"
          end 

    end

    def update_patient
        @patient = Patient.find(params[:id])
        @action = "update_patient"
        render :new_patient
    end

    def save_updated_patient
        @patient = Patient.find(params[:id])

        # binding.pry

        if @patient.update(patient_params)
            flash[:notice] = "Patient updated"
            redirect_to action: "see_all_patients"
          else
            flash[:alert] = "Patient not updated, please try again later"
            render :update_patient
          end
    end

    def destroy_patient        
        @patient = Patient.find(params[:id])

        if  @patient.destroy
         flash[:notice] = "patient Deleted"
        else
         flash[:alert] = "Error deleting patient"
        end
        redirect_to action: "see_all_patients"
    end


    def authorize_is_doctor!
        if current_user.is_doctor?
          redirect_to root_path
        end
    end


    private

    def patient_params
    params.permit(:name, :email, :number, :birthdate)
    end


end
