class ExpensesController < ApplicationController
    before_action :set_expense, only: [:show, :edit, :update, :destroy]

    def index
        @expenses = Expense.all
    end

    def show
        @expense = Expense.find(params[:id])
    end

    def new
        @expense = Expense.new
    end

    def create
        @expense = Expense.new(expense_params)
        if @expense.save
            redirect_to expenses_path, notice: 'Expense was successfully created.'
        else
            render :new
        end
    end

    def edit
        @expense = Expense.find(params[:id])
    end

    def update
        @expense = Expense.find(params[:id])
        if @expense.update(expense_params)
            redirect_to expenses_path, notice: 'Expense was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @expense = Expense.find(params[:id])
        @expense.destroy
        redirect_to expenses_path, notice: 'Expense was successfully destroyed.'
    end

    private

    def set_expense
        @expense = Expense.find(params[:id])
    end

    def expense_params
        params.require(:expense).permit(:category, :name, :amount, :date)
    end
end
