module Api
  module V1
    class AnamnesesController < ApplicationController
      before_action :set_anamnesis, only: %i[show update destroy]

      def index
        data = Anamnesis.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: AnamnesisSerializer
        ).to_a

        render_success_response(data: { anamneses: response })
      end

      def show
        render_success_response(data: { anamnesis: anamnesis_serializer(@anamnesis) })
      end

      def create
        anamnesis = Anamnesis.new(anamnesis_params)

        if anamnesis.save
          render_success_response(data: { anamnesis: }, status: :created)
        else
          render_error_response(
            error:   anamnesis.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'Anamnesis data could not be created'
          )
        end
      end

      def update
        if @anamnesis.update(anamnesis_params)
          render_success_response(data: { anamnesis: @anamnesis }, status: :created)
        else
          render_error_response(
            error:   @anamnesis.errors.full_messages,
            status:  :unprocessable_entity,
            message: 'Anamnesis could not be updated'
          )
        end
      end

      def destroy
        if @anamnesis.destroy
          render_success_response(message: 'Anamnesis deleted successfully')
        else
          render_error_response(
            error:   @anamnesis.errors.full_messages,
            status:  404,
            message: 'Anamnesis could not be deleted'
          )
        end
      end

      private

      def set_anamnesis
        @anamnesis = Anamnesis.find(params[:id])
      end

      def anamnesis_params
        params.require(:anamnesis).permit(*Anamnesis::WHITELISTED_ATTRIBUTES)
      end

      def anamnesis_serializer(anamnesis)
        AnamnesisSerializer.new.serialize(anamnesis)
      end
    end
  end
end
