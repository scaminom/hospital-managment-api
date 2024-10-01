module Api
  module V1
    class DoctorsController < ApplicationController
      before_action :set_doctor, only: %i[show update destroy]

      def index
        data = Doctor.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: DoctorSerializer
        ).to_a

        render_success_response(data: { doctors: response })
      end

      def show
        render_success_response(data: { doctor: doctor_serializer(@doctor) })
      end

      def create
        doctor = DoctorRegistrationService.new(doctor_params).call
        if doctor.persisted?
          render_success_response(
            data:    doctor_serializer(doctor),
            message: 'Doctor created successfully',
            status:  :created
          )
        else
          render_error_response(
            error:   doctor.errors.full_messages,
            message: 'Failed to create doctor',
            status:  :unprocessable_entity
          )
        end
      end

      def update
        if @doctor.update(doctor_params)
          render_success_response(data: { doctor: @doctor }, status: :created)
        else
          render_error_response(
            error:   @doctor.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'doctor could not be updated'
          )
        end
      end

      def destroy
        if @doctor.destroy
          render_success_response(message: 'doctor deleted successfully')
        else
          render_error_response(
            error:   @doctor.errors.full_messages,
            status:  404,
            message: 'doctor could not be deleted'
          )
        end
      end

      private

      def set_doctor
        @doctor = Doctor.find(params[:id])
      end

      def doctor_params
        params.require(:doctor).permit(*Doctor::WHITELISTED_ATTRIBUTES)
      end

      def doctor_serializer(doctor)
        DoctorSerializer.new.serialize(doctor)
      end
    end
  end
end
