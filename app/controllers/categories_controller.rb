class CategoriesController < ApplicationController

	def index
		@cats = Category.all.order('category_title ASC')
	end

	def new
		if current_user.admin?
			@cat = Category.new
		else
			redirect_to posts_path
		end
	end

	def create
		if current_user.admin?
			@cat = Category.new(category_params)
			
			if @cat.save
				redirect_to categories_path
			else
				render 'new'
			end
		else
			redirect_to posts_path
		end
	end

	def show
		@cat = Category.find(params[:id])
	end

	def edit
		if current_user.admin?
			@cat = Category.find(params[:id])
		else
			redirect_to posts_path
		end
	end

	def update
		@cat = Category.find(params[:id])
		if @cat.update(params[:category].permit(:category_title, :blog))
			redirect_to categories_path
		else
			render 'edit'
		end
	end

	def destroy
		if current_user.writer? || current_user.admin?
			@cat = Category.find(params[:id])
			@cat.destroy

			redirect_to categories_path
		else
			redirect_to categories_path
		end
	end

	private
	def category_params
		params.require(:category).permit(:category_title, :blog)
	end
end
