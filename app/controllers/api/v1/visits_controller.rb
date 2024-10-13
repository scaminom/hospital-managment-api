module Api
  module V1
    class VisitsController < ApplicationController
      before_action :set_visit, only: %i[show update destroy prescriptions laboratory_results]

      def index
        data = Visit.includes(:medical_record, :doctor).all

        response = Panko::ArraySerializer.new(
          data, each_serializer: VisitSerializer
        ).to_a

        render_success_response(data: { visits: response })
      end

      def show
        render_success_response(
          data: {
            visit: VisitSerializer.new(
              only: %i[id visit_type created_at priority_level patient_name room anamnesis medical_record doctor]
            ).serialize(@visit)
          }
        )
      end

      def create
        visit_type = params[:type]&.to_sym || :regular
        visit = VisitFactory.create(visit_type, visit_params)

        if visit.save
          render_success_response(data: { visit: serialize(visit) }, status: :created)
        else
          render_error_response(
            error:   visit.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'Visit data could not be created'
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

      def prescriptions
        data = @visit.prescriptions

        response = Panko::ArraySerializer.new(
          data, each_serializer: PrescriptionSerializer
        ).to_a

        render_success_response(data: { prescriptions: response })
      end

      def laboratory_results
        data = @visit.laboratory_results

        response = Panko::ArraySerializer.new(
          data, each_serializer: LaboratoryResultSerializer
        ).to_a

        render_success_response(data: { laboratory_results: response })
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
    end
  end
end
