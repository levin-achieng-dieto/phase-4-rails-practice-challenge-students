class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found_record
rescue_from ActiveRecord::RecordInvalid, with: :rescue_from_invalid_record

    def index
        render json: Student.all, status: :ok
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

    def create
        student = Student.create!(create_student)
        render json: student, status: :created
    end

    def update
        student = Student.find(params[:id])
        student.update
        render json: student, status: :updated
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        render json: student, status: :not_found
    end

    private

    def create_student
        params.permit(:name, :major, :age)
    end

    def rescue_not_found_record
        render json: {errors: "Student not found"}, status: :not_found
    end

    def rescue_from_invalid_record(e)
        render json: {error: e.record.errors.full_messages}, status: :unprocessable_entity
    end
end
