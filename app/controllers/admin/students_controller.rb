class Admin::StudentsController < Admin::BaseController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to admin_students_path
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    Student.find(params[:id]).update_attributes(student_params)
    redirect_to admin_students_path
  end

  def student_params
    params.require(:student).permit(:name, :slack_uid, :posse_id, :slack_name)
  end
end
