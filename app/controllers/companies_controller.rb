class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: %i[show edit update destroy]

  def index
    @companies = policy_scope(Company)
    authorize Company
  end

  def show
    authorize @company
  end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @company }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @company
  end

  def update
    authorize @company
    if @company.update(company_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @company }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @company
    @company.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to companies_path }
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :industry)
  end
end
