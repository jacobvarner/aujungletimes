class CategoriesController < ApplicationController
	def index
		@cats = Category.all.order('category_title')
	end

	def new
		@cat = Category.new
	end

	def create
		@cat = Category.new(category_params)
		
		if @cat.save
			redirect_to @cat
		else
			render 'new'
		end
	end

	def show
		@cat = Category.find(params[:id])
	end

	def edit
		@cat = Category.find(params[:id])
	end

	def update
		@cat = Category.find(params[:id])
		if @cat.update(params[:category].permit(:category_title, :blog))
			redirect_to @cat
		else
			render 'edit'
		end
	end

	def destroy
		@cat = Category.find(params[:id])
		@cat.destroy

		redirect_to category_path
	end

	private
	def category_params
		params.require(:category).permit(:category_title, :blog)
	end
end
