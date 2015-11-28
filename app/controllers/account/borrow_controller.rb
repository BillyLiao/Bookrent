class Account::BorrowController < ApplicationController
	before_action :authenticate_user!
	skip_before_filter :verify_authenticity_token, :only => :create

	def index
		redirect_to account_borrow_path(current_user)
    end

    def show
   		@books = Book.where(user_id: current_user.id)
   	end

    def create
    	@book = Book.find(params[:book_id])
    	@book.borrowed_at = Time.current
    	@book.returned_at = @book.borrowed_at + 7.days
    	@book.user_id = current_user.id
    	@book.left = @book.left - 1
    	@book.save

    	redirect_to account_borrow_path(current_user)
    end

end
