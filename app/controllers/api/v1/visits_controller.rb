module Api
  module V1
    class VisitsController < ApplicationController
      before_action :set_visit, only: %i[show update destroy]

      def index
        data = Visit.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: VisitSerializer
        ).to_a

        render_success_response(data: { visits: response })
      end

      def show
        render_success_response(data: { visit: visit_serializer(@visit) })
      end

      # def create
      #   visit = Visit.new(visit_params)

      #   if visit.save
      #     render_success_response(data: { visit: visit_serializer(visit) }, status: :created)
      #   else
      #     render_error_response(
      #       error:   visit.errors.full_messages,
      #       status:  :unprocessable_entity,
      #       message: 'visit data could not be created'
      #     )
      #   end
      # end

      def create_regular
        visit = CreateRegularVisitService.call(visit_params)

        if visit.save
          render_success_response(data: { visit: visit_serializer(visit) }, status: :created)
        else
          render_error_response(
            error:   visit.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'visit data could not be created'
          )
        end
      end

      def create_emergency
        visit = CreateEmergencyVisitService.call(visit_params)

        if visit.save
          render_success_response(data: { visit: visit_serializer(visit) }, status: :created)
        else
          render_error_response(
            error:   visit.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'visit data could not be created'
          )
        end
      end

      def update
        if @visit.update(visit_params)
          render_success_response(data: { visit: @visit }, status: :created)
        else
          render_error_response(
            error:   @visit.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'visit could not be updated'
          )
        end
      end

      def destroy
        if @visit.destroy
          render_success_response(message: 'visit deleted successfully')
        else
          render_error_response(
            error:   @visit.errors.full_messages,
            status:  404,
            message: 'visit could not be deleted'
          )
        end
      end

      private

      def set_visit
        @visit = Visit.find(params[:id])
      end

      def visit_params
        params.require(:visit).permit(*Visit::WHITELISTED_ATTRIBUTES)
      end

      def visit_serializer(visit)
        VisitSerializer.new.serialize(visit)
      end
    end
  end
end
