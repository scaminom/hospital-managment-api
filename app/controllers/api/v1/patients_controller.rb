module Api
  module V1
    class PatientsController < ApplicationController
      before_action :set_patient, only: %i[show update destroy medical_record visits]

      def index
        data = Patient.includes(:medical_record).all

        response = Panko::ArraySerializer.new(
          data,
          each_serializer: PatientSerializer,
          except:          [:anamnesis]
        ).to_a

        render_success_response(data: { patients: response })
      end

      def visits
        visits = @patient.visits.includes(:doctor)

        response = Panko::ArraySerializer.new(
          visits,
          each_serializer: VisitSerializer,
          only:            [:id, :visit_type, :created_at, :priority_level]
        ).to_a

        render_success_response(data: { visits: response })
      end

      def show
        render_success_response(
          data: {
            patient: PatientSerializer.new(except: [:anamnesis]).serialize(@patient)
          }
        )
      end

      def create
        patient = PatientRegistrationService.new(patient_params).call
        if patient.persisted?
          render_success_response(
            data: {
              patient: PatientSerializer.new(except: [:anamnesis]).serialize(@patient)
            }, status: :created
          )
        else
          render_error_response(
            patient.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'Patient could not be created'
          )
        end
      end

      def update
        if @patient.update(patient_params)
          render_success_response(
            data: {
              patient: PatientSerializer.new(except: [:anamnesis]).serialize(@patient)
            }, status: :created
          )
        else
          render_error_response(
            @patient.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'patient could not be updated'
          )
        end
      end

      def destroy
        if @patient.destroy
          render_success_response(message: 'patient deleted successfully')
        else
          render_error_response(
            @patient.errors.full_messages,
            status:  404,
            message: 'patient could not be deleted'
          )
        end
      end

      def medical_record
        medical_record = @patient.medical_record
        if medical_record
          render_success_response(data: { medical_record: medical_record_serializer(medical_record) })
        else
          render_error_response(
            error:   ['Medical record not found'],
            status:  :not_found,
            message: 'Medical record could not be retrieved'
          )
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

      def medical_record_serializer(medical_record)
        MedicalRecordSerializer.new.serialize(medical_record)
      end
    end
  end
end
