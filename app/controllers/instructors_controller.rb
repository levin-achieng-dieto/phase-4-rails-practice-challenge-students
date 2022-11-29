class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid_record
rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_record_not_found
    def index
        render json: Instructor.all, status: :ok
    end

    def show
    instructor = Instructor.find(params[:id])
    render json: instructor
    end

    def create
    instructor = Instructor.create!(create_instructor)
    render json: instructor, status: :created
    end

    def update
    instructor = Instructor.find(params[:id])
    render json: instructor, status: :updated
    end

    def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    render json: instructor, status: :not_found
    end

    private

    def create_instructor
        params.permit(:name)
    end

    def rescue_invalid_record(e)
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def rescue_from_record_not_found
        render json: {error: "Instructor not found"}, status: :not_found
    end
end
