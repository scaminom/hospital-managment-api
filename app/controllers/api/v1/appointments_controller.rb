module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :set_appointment, only: %i[show update destroy]

      def index
        data = Appointment.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: AppointmentSerializer
        ).to_a

        render_success_response(data: { appointments: response })
      end

      def show
        render_success_response(data: { appointment: appointment_serializer(@appointment) })
      end

      def create
        appointment = Appointment.new(appointment_params)

        if appointment.save
          render_success_response(data: { appointment: appointment_serializer(appointment) }, status: :created)
        else
          render_error_response(
            error:   appointment.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'appointment data could not be created'
          )
        end
      end

      def update
        if @appointment.update(appointment_params)
          render_success_response(data: { appointment: appointment_serializer(@appointment) }, status: :created)
        else
          render_error_response(
            error:   @appointment.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'appointment could not be updated'
          )
        end
      end

      def destroy
        if @appointment.destroy
          render_success_response(message: 'appointment deleted successfully')
        else
          render_error_response(
            error:   @appointment.errors.full_messages,
            status:  404,
            message: 'appointment could not be deleted'
          )
        end
      end

      private

      def set_appointment
        @appointment = Appointment.find(params[:id])
      end

      def appointment_params
        params.require(:appointment).permit(*Appointment::WHITELISTED_ATTRIBUTES)
      end

      def appointment_serializer(appointment)
        AppointmentSerializer.new.serialize(appointment)
      end
    end
  end
end
