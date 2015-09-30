class BlogsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@blogs = Blog.all.order('created_at DESC')
	end

	def new
		if current_user.writer? || current_user.admin?
			@blog = Blog.new
		else
			redirect_to blogs_path
		end
	end

	def create
		if current_user.writer? || current_user.admin?
			@blog = Blog.new(blog_params)
			@blog.post_author = current_user.username
			
			if @blog.save
				redirect_to @blog
			else
				render 'new'
			end
		else
			redirect_to blogs_path
		end
	end

	def show
		@blog = Blog.find(params[:id])
	end

	def edit
		if current_user.writer? || current_user.admin?
			@blog = Blog.find(params[:id])
		else
			redirect_to blogs_path
		end
	end

	def update
		if current_user.writer? || current_user.admin?
			@blog = Blog.find(params[:id])
			@blog.date_edited = Time.now
			if @blog.update(params[:blog].permit(:post_title, :post_content))
				redirect_to @blog
			else
				render 'edit'
			end
		else
			redirect_to blogs_path
		end
	end

	def destroy
		if current_user.writer? || current_user.admin?
			@blog = Blog.find(params[:id])
			@blog.destroy

			redirect_to blogs_path
		else
			redirect_to blogs_path
		end
	end

	private
	def blog_params
		params.require(:blog).permit(:post_title, :post_author, :post_description, :post_content, :category, :post_image, :date_created, :date_edited, :publish)
	end
end
