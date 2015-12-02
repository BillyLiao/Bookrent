class BooksController < ApplicationController

	 before_filter :authenticate_user!, :only => [:new, :create]
     


	def index
        if !if_logged_in?
            redirect_to new_user_session_path
        else
            @books = Book.all
        end

	end

	def new
		@book = Book.new
    end

    def create
    	@book = Book.new(book_params)

    	if @book.left != 0
			@book.save
    		flash[:notice] = "Successfully Created!"
    		redirect_to books_path
    	else
        	flash[:alert] = "Invalid data format!"
        	render new_book_path(@book)
    	end

    end

    def destroy
        @book = Book.find(params[:book_id])
        @book.destroy

        redirect_to books_path
    end

    def edit
        @book = Book.find(params[:book_id])
        
    end

    def update

        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = 'Successfully Edit.'
            redirect_to books_path
        else
            render :edit
        end
    end

    private

   	def book_params
   		params.require(:book).permit(:name,:writer,:left,:borrowed_at,:returned_at)
    end


end