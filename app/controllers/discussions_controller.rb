class DiscussionsController < ApplicationController
		before_action :authenticate_user!, except: [:index, :show]

		def index
			@discussions = Discussion.paginate(:page => params[:page], per_page: 20).order('created_at DESC')
		end

		def new
			@discussion = Discussion.new
		end

		def create
			@discussion = Discussion.new(discussion_params)
			@discussion.creator = current_user.username

			if @discussion.save
				redirect_to @discussion
			else
				render 'new'
			end
		end

		def update
			@discussion = Discussion.friendly.find(params[:id])
			if @discussion.update(params[:discussion].permit(:title, :content, :link, :category))
				redirect_to @discussion
			else
				render 'edit'
			end
		end

		def edit
			@discussion = Discussion.friendly.find(params[:id])
		end

		def show
			@discussion = Discussion.friendly.find(params[:id])
		end

		def destroy
			if current_user.admin?
				@discussion = Discussion.friendly.find(params[:id])
				@discussion.destroy

				redirect_to discussions_path
			else
				redirect_to discussions_path
			end
		end

		def plus
			@discussion = Discussion.friendly.find(params[:id])
			@discussion.upvote_by current_user
			@discussion.score = (@discussion.get_upvotes.size - @discussion.get_downvotes.size)
			redirect_to :back
		end

		def minus
			@discussion = Discussion.friendly.find(params[:id])
			@discussion.downvote_by current_user
			@discussion.score = (@discussion.get_upvotes.size - @discussion.get_downvotes.size)
			redirect_to :back
		end

		private
		def discussion_params
			params.require(:discussion).permit(:title, :link, :content, :creator, :category, :score)
		end
end
