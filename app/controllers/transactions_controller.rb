class TransactionsController < ApplicationController
    before_action :authenticate_user!, :set_transaction, only: [:show, :edit, :update, :destroy]

    helper_method :sort_direction, :sort_column

    def index
        @transactions = current_user.transactions.order(sort_column => sort_direction)
    end

    def show
        @transaction = current_user.transactions.find(params[:id])
    end

    def new
        @transaction = current_user.transactions.new
    end

    def create
        @transaction = current_user.transactions.new(transaction_params)
        if @transaction.save
            redirect_to transactions_path, notice: 'Transaction was successfully created.'
        else
            render :new
        end
    end

    def edit
        @transaction = current_user.transactions.find(params[:id])
    end

    def update
        @transaction = current_user.transactions.find(params[:id])
        if @transaction.update(transaction_params)
            redirect_to transactions_path, notice: 'Transaction was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @transaction = current_user.transactions.find(params[:id])
        @transaction.destroy
        redirect_to transactions_path, notice: 'Transaction was successfully destroyed.'
    end

    private

    def set_transaction
        @transaction = current_user.transactions.find(params[:id])
    end

    def transaction_params
        params.require(:transaction).permit(:category, :name, :amount, :date)
    end

    def sort_column
        %w[name category amount date].include?(params[:sort]) ? params[:sort] : "date"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
