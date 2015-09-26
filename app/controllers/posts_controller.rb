class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all.order('created_at DESC')
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.post_author = current_user.username
		@post.date_created = Time.now
		
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@post.date_edited = Time.now
		if @post.update(params[:post].permit(:post_title, :post_content))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to blog_path
	end

	private
	def post_params
		params.require(:post).permit(:post_title, :post_author, :post_description, :post_content, :category, :post_image, :date_created, :date_edited, :publish, :bootsy_image_gallery_id)
	end
end
