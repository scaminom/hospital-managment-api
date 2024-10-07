module Api
  module V1
    class MedicalRecordsController < ApplicationController
      before_action :set_medicalRecord, only: %i[show update destroy]

      def index
        data = MedicalRecord.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: MedicalRecordSerializer
        ).to_a

        render_success_response(data: { medicalRecords: response })
      end

      def show
        render_success_response(data: { medicalRecord: medical_record_serializer(@medical_record) })
      end

      def create
        medical_record = MedicalRecord.new(medical_record_params)

        if medical_record.save
          render_success_response(data: { medical_record: }, status: :created)
        else
          render_error_response(
            medical_record.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'Medical record data could not be created'
          )
        end
      end

      def update
        if @medical_record.update(medical_record_params)
          render_success_response(data: { medical_record: @medical_record }, status: :created)
        else
          render_error_response(
            @medical_record.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'Medical record could not be updated'
          )
        end
      end

      def destroy
        if @medicalRecord.destroy
          render_success_response(message: 'Medical record deleted successfully')
        else
          render_error_response(
            @medicalRecord.errors.full_messages,
            status:  404,
            message: 'Medical record could not be deleted'
          )
        end
      end

      private

      def set_medical_record
        @medical_record = MedicalRecord.find(params[:id])
      end

      def medical_record_params
        params.require(:medicalRecord).permit(*MedicalRecord::WHITELISTED_ATTRIBUTES)
      end

      def medical_record_serializer(medical_record)
        MedicalRecordSerializer.new.serialize(medical_record)
      end
    end
  end
end
