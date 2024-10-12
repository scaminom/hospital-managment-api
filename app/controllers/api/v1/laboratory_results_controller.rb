module Api
  module V1
    class LaboratoryResultsController < ApplicationController
      before_action :set_laboratory_result, only: %i[show update destroy]

      def index
        data = LaboratoryResult.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: LaboratoryResultSerializer
        ).to_a

        render_success_response(data: { laboratory_results: response })
      end

      def show
        render_success_response(data: { laboratory_result: laboratory_result_serializer(@laboratory_result) })
      end

      def create
        laboratory_result = LaboratoryResult.new(laboratory_result_params.except(:status))

        if laboratory_result.save
          render_success_response(data: { laboratory_result: }, status: :created)
        else
          render_error_response(
            error:   laboratory_result.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'laboratory_result data could not be created'
          )
        end
      end

      def update
        if @laboratory_result.update(laboratory_result_params)
          render_success_response(data: { laboratory_result: @laboratory_result }, status: :created)
        else
          render_error_response(
            error:   @laboratory_result.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'laboratory_result could not be updated'
          )
        end
      end

      def destroy
        if @laboratory_result.destroy
          render_success_response(message: 'laboratory_result deleted successfully')
        else
          render_error_response(
            error:   @laboratory_result.errors.full_messages,
            status:  404,
            message: 'laboratory_result could not be deleted'
          )
        end
      end

      private

      def set_laboratory_result
        @laboratory_result = LaboratoryResult.find(params[:id])
      end

      def laboratory_result_params
        params.require(:laboratory_result).permit(*LaboratoryResult::WHITELISTED_ATTRIBUTES)
      end

      def laboratory_result_serializer(laboratory_result)
        LaboratoryResultSerializer.new.serialize(laboratory_result)
      end
    end
  end
end
