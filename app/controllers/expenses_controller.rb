class ExpensesController < ApplicationController
    before_action :authenticate_user!, :set_expense, only: [:show, :edit, :update, :destroy]

    helper_method :sort_direction, :sort_column

    def index
        @expenses = current_user.expenses.order(sort_column => sort_direction)
    end

    def show
        @expense = current_user.expenses.find(params[:id])
    end

    def new
        @expense = current_user.expenses.new
    end

    def create
        @expense = current_user.expenses.new(expense_params)
        if @expense.save
            redirect_to expenses_path, notice: 'Expense was successfully created.'
        else
            render :new
        end
    end

    def edit
        @expense = current_user.expenses.find(params[:id])
    end

    def update
        @expense = current_user.expenses.find(params[:id])
        if @expense.update(expense_params)
            redirect_to expenses_path, notice: 'Expense was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @expense = current_user.expenses.find(params[:id])
        @expense.destroy
        redirect_to expenses_path, notice: 'Expense was successfully destroyed.'
    end

    private

    def set_expense
        @expense = current_user.expenses.find(params[:id])
    end

    def expense_params
        params.require(:expense).permit(:category, :name, :amount, :date)
    end

    def sort_column
        %w[name category amount date].include?(params[:sort]) ? params[:sort] : "date"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
