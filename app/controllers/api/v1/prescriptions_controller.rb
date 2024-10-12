module Api
  module V1
    class PrescriptionsController < ApplicationController
      before_action :set_prescription, only: %i[show update destroy]

      def index
        data = Prescription.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: PrescriptionSerializer
        ).to_a

        render_success_response(data: { prescriptions: response })
      end

      def show
        render_success_response(data: { prescription: prescription_serializer(@prescription) })
      end

      def create
        prescription = Prescription.new(prescription_params.except(:status))

        if prescription.save
          render_success_response(data: { prescription: }, status: :created)
        else
          render_error_response(
            error:   prescription.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'Prescription data could not be created'
          )
        end
      end

      def update
        if @prescription.update(prescription_params)
          render_success_response(data: { prescription: @prescription }, status: :created)
        else
          render_error_response(
            error:   @prescription.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'Prescription could not be updated'
          )
        end
      end

      def destroy
        if @prescription.destroy
          render_success_response(message: 'Prescription deleted successfully')
        else
          render_error_response(
            error:   @prescription.errors.full_messages,
            status:  404,
            message: 'Prescription could not be deleted'
          )
        end
      end

      private

      def set_prescription
        @prescription = Prescription.find(params[:id])
      end

      def prescription_params
        params.require(:prescription).permit(*Prescription::WHITELISTED_ATTRIBUTES)
      end

      def prescription_serializer(prescription)
        PrescriptionSerializer.new.serialize(prescription)
      end
    end
  end
end
