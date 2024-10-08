module Api
  module V1
    class VisitsController < ApplicationController
      before_action :set_visit, only: %i[show update destroy]

      def index
        visits = Visit.includes(:medical_record, :doctor).all
        render_success_response(data: { visits: serialize_collection(visits) })
      end

      def show
        render_success_response(data: { visit: serialize(@visit) })
      end

      def create
        visit = VisitFactory.create(params[:visit_type], visit_params)

        if visit.save!
          render_success_response(data: { visit: serialize(visit) }, status: :created)
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
          render_success_response(data: { visit: serialize(@visit) })
        else
          render_error_response(errors: @visit.errors, status: :unprocessable_entity)
        end
      end

      def destroy
        @visit.destroy
        render_success_response(message: 'Visit deleted successfully')
      end

      private

      def set_visit
        @visit = Visit.find(params[:id])
      end

      def visit_params
        params.require(:visit).permit(*Visit::WHITELISTED_ATTRIBUTES)
      end

      def serialize(visit)
        VisitSerializer.new.serialize(visit)
      end

      def serialize_collection(visits)
        VisitSerializer.new(visits).serializable_hash
      end
    end
  end
end
