module Api
  module V1
    class DepartmentsController < ApplicationController
      before_action :set_department, only: %i[show update destroy]

      def index
        data = Department.all

        response = Panko::ArraySerializer.new(
          data, each_serializer: DepartmentSerializer
        ).to_a

        render_success_response(data: { departments: response })
      end

      def show
        render_success_response(data: { department: department_serializer(@department) })
      end

      def create
        department = Department.new(department_params)

        if department.save
          render_success_response(data: { department: }, status: :created)
        else
          render_error_response(department.errors.full_messages, status:  :unprocessable_entity,
                                                                 message: 'department data could not be created')
        end
      end

      def update
        if @department.update(department_params)
          render_success_response(data: { department: @department }, status: :created)
        else
          render_error_response(@department.errors.full_messages, status:  :unprocessable_entity,
                                                                  message: 'department could not be updated')
        end
      end

      def destroy
        if @department.destroy
          render_success_response(message: 'department deleted successfully')
        else
          render_error_response(@department.errors.full_messages, status:  404,
                                                                  message: 'department could not be deleted')
        end
      end

      private

      def set_department
        @department = Department.find(params[:id])
      end

      def department_params
        params.require(:department).permit(*Department::WHITELISTED_ATTRIBUTES)
      end

      def department_serializer(department)
        DepartmentSerializer.new.serialize(department)
      end
    end
  end
end
