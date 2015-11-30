class Account::BorrowController < ApplicationController
	before_action :authenticate_user!
	skip_before_filter :verify_authenticity_token, :only => [:create, :delete]

	def index
		redirect_to account_borrow_path(current_user)
    end

    def show
   		@books = Book.where(user_id: current_user.id)
   	end

    def create
    	@book = Book.find(params[:book_id])
        if @book.user_id != current_user.id
    	   @book.borrowed_at = Time.current
    	   @book.returned_at = @book.borrowed_at + 7.days
    	   @book.user_id = current_user.id
    	   @book.left = @book.left - 1
    	   @book.save
        else
            flash[:alert] = 'The book is unavailable now.'
        end

    	redirect_to account_borrow_path(current_user)
    end

    def delete_borrow

        @book = Book.find(params[:book_id])
        if @book.user_id != nil
            @book.borrowed_at = nil
            @book.returned_at = nil
            @book.user_id = nil
            @book.left = @book.left + 1
            @book.save
        else
            flash[:alert] = 'No one borrowed the book.'
        end
    	
    	redirect_to root_path
    end

end
