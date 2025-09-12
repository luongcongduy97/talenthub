class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: %i[show edit update destroy]

  def index
    @employees = policy_scope(Employee)
    if params[:query].present?
      @employees = @employees.search_by_name_and_position(params[:query].to_s)
    end
    authorize Employee
  end

  def show
    authorize @employee
  end

  def new
    @employee = Employee.new
    authorize @employee
  end

  def create
    @employee = Employee.new(employee_params)
    authorize @employee
    if @employee.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @employee }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @employee
  end

  def update
    authorize @employee
    if @employee.update(employee_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @employee }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @employee
    @employee.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to employees_path }
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :position, :company_id, :user_id)
  end
end
