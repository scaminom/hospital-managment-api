module Api
  module V1
    class DoctorsController < ApplicationController
      before_action :set_doctor, only: %i[show]

      def index
        data = Doctor.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: DepartmentSerializer
        ).to_a

        render_success_response(data: { departments: response })
      end

      def show
        render_success_response(data: { doctor: doctor_serializer(@doctor) })
      end

      def create
        result = DoctorRegistrationService.new(doctor_params).call
        if result.success?
          render_success_response(data: doctor_serializer(result.data), message: 'Doctor created successfully',
                                  status: :created)
        else
          render_error_response(error: result.errors, message: 'Failed to create doctor', status: :unprocessable_entity)
        end
      end

      private

      def set_doctor
        @doctor = Doctor.find(params[:id])
      end

      def doctor_params
        params.require(:doctor).permit(Doctor::WHITELISTED_ATTRIBUTES)
      end

      def doctor_serializer(doctor)
        DoctorSerializer.new.serialize(doctor)
      end
    end
  end
end

