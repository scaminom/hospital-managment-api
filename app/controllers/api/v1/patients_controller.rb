module Api
  module V1
    class PatientsController < ApplicationController
      before_action :set_patient, only: %i[show update destroy]

      def index
        data = Patient.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: PatientSerializer
        ).to_a

        render_success_response(data: { patients: response })
      end

      def show
        render_success_response(data: { patient: patient_serializer(@patient) })
      end

      def create
        patient = Patient.new(patient_params)

        if patient.save
          render_success_response(data: { patient: }, status: :created)
        else
          render_error_response(patient.errors.full_messages, status:  :unprocessable_entity,
                                                              message: 'patient data could not be created')
        end
      end

      def update
        if @patient.update(patient_params)
          render_success_response(data: { patient: @patient }, status: :created)
        else
          render_error_response(@patient.errors.full_messages, status:  :unprocessable_entity,
                                                               message: 'patient could not be updated')
        end
      end

      def destroy
        if @patient.destroy
          render_success_response(message: 'patient deleted successfully')
        else
          render_error_response(@patient.errors.full_messages, status:  404,
                                                               message: 'patient could not be deleted')
        end
      end

      private

      def set_patient
        @patient = Patient.find(params[:id])
      end

      def patient_params
        params.require(:patient).permit(*Patient::WHITELISTED_ATTRIBUTES)
      end

      def patient_serializer(patient)
        PatientSerializer.new.serialize(patient)
      end
    end
  end
end
