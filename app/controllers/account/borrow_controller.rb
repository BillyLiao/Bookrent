class Account::BorrowController < ApplicationController
	before_action :authenticate_user! 
    before_action :if_borrow_valid?, :only => :create
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

        if @book.returned_at.nil? || Time.now > @book.returned_at
            id = @book.user_id
            @user = User.find(params[:id])
            flash[:alert] = @user.email + ' is under registrction for 7 days'
            @user.restriction = true
            @user.restriction_date = Time.now + 7.days
            @user.save
        end

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

    protected
    
    def if_borrow_valid?

        @books = Book.where(params[:current_user])
            

        if current_user.restriction_date.nil? || Time.now > current_user.restriction_date
            current_user.restriction = false
        end

        if current_user.books.count == 3
            flash[:alert] = "You can only borrow three books!"
            redirect_to root_path
            return
        end

        if current_user.restriction 
            flash[:alert] = 'You are under registration until ' + @current_user.restriction_date.to_s
            redirect_to root_path
            return
        end

        @books.each do |f| 
            if Time.now > f.returned_at
                flash[:alert] = 'You need to return ' + f.name + ' if you want to borrow.'
                redirect_to root_path
                return
            end
        end


    end

    
end
