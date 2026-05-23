class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: %i[show edit update destroy]

  def index
    @budgets = current_user.budgets.order(period_start: :desc)
  end

  def show
    @status = @budget.category_status
  end

  def new
    @budget = current_user.budgets.new(period_start: Date.current.beginning_of_month)
    3.times { @budget.budget_categories.build }
  end

  def create
    @budget = current_user.budgets.new(budget_params)
    if @budget.save
      redirect_to @budget, notice: "Budget was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @budget.budget_categories.build if @budget.budget_categories.empty?
  end

  def update
    if @budget.update(budget_params)
      redirect_to @budget, notice: "Budget was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @budget.destroy
    redirect_to budgets_path, notice: "Budget was successfully deleted."
  end

  private

  def set_budget
    @budget = current_user.budgets.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:title, :income_per_month, :period_start,
      budget_categories_attributes: [:id, :name, :amount, :_destroy])
  end
end
