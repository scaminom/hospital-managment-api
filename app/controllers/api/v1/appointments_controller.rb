module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :set_appointment, only: %i[show update destroy]

      def index
        appointments = Appointment.includes(:patient, :doctor, :visit).all
        render_success_response(data: { appointments: serialize_collection(appointments) })
      end

      def show
        render_success_response(data: { appointment: serialize(@appointment) })
      end

      def create
        appointment = Appointment.new(appointment_params)

        if appointment.save
          render_success_response(data: { appointment: serialize(appointment) }, status: :created)
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
          render_success_response(data: { appointment: serialize(@appointment) })
        else
          render_error_response(errors: @appointment.errors, status: :unprocessable_entity)
        end
      end

      def destroy
        @appointment.destroy
        render_success_response(message: 'Appointment deleted successfully')
      end

      private

      def set_appointment
        @appointment = Appointment.find(params[:id])
      end

      def appointment_params
        params.require(:appointment).permit(*Appointment::WHITELISTED_ATTRIBUTES)
      end

      def serialize(appointment)
        AppointmentSerializer.new.serialize(appointment)
      end

      def serialize_collection(appointments)
        AppointmentSerializer.new.serialize(appointments)
      end
    end
  end
end
