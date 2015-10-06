class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.where(publish: true).paginate(:page => params[:page], per_page: 12).order('created_at DESC')
	end

	def new
		if current_user.writer? || current_user.admin?
			@post = Post.new
		else
			redirect_to posts_path
		end
	end

	def create
		if current_user.writer? || current_user.admin?
			@post = Post.new(post_params)
			@post.post_author = current_user.username
			
			if @post.save
				redirect_to @post
			else
				render 'new'
			end
		else
			redirect_to posts_path
		end
	end

	def show
		@post = Post.friendly.find(params[:id])
	end

	def edit
		if current_user.writer? || current_user.admin?
			@post = Post.friendly.find(params[:id])
		else
			redirect_to posts_path
		end
	end

	def update
		if current_user.writer? || current_user.admin?
			@post = Post.friendly.find(params[:id])
			if @post.update(params[:post].permit(:post_title, :post_content, :post_image, :post_description, :publish, :post_category))
				redirect_to @post
			else
				render 'edit'
			end
		else
			redirect_to posts_path
		end
	end

	def destroy
		if current_user.writer? || current_user.admin?
			@post = Post.friendly.find(params[:id])
			@post.destroy

			redirect_to :back
		else
			redirect_to posts_path
		end
	end

	def panel
		if current_user.admin? || current_user.writer?
			@posts = Post.paginate(:page => params[:page], per_page: 25).order('created_at DESC')
		else
			redirect_to posts_path
		end
	end

	private
	def post_params
		params.require(:post).permit(:post_title, :post_author, :post_description, :post_content, :category, :post_image, :publish)
	end
end
