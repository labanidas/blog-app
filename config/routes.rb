Rails.application.routes.draw do
  devise_for :users

  # routes for doctor
  constraints ->(request) { request.env['warden'].user&.is_doctor } do
    # see the graph
    get '/', to: 'doctor#graph'
    get '/all-patients', to: 'doctor#all_patients'
    # see appointments
  end

  # routes for receptionist
  constraints ->(request) { !request.env['warden'].user&.is_doctor? } do
    get '/', to: 'receptionist#see_all_patients'
    # see all patients
    # add new patient
    get 'new-patient', to: 'receptionist#new_patient'
    post 'new-patient', to: 'receptionist#add_patient'
    # update existing patient
    get 'edit-patient/:id', to: "receptionist#update_patient"
    post 'edit-patient/:id', to: "receptionist#save_updated_patient"
    # delete a patient
    delete  'delete-patient/:id', to: 'receptionist#destroy_patient'
    # book appointment
    # delete an appointment
  end


  root to: 'base#home'

end
