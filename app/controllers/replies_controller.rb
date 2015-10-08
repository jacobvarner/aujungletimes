class RepliesController < ApplicationController
	def create
		@discussion = Discussion.friendly.find(params[:discussion_id])
		@reply = @discussion.replies.create(params[:reply].permit(:username, :body))
		@discussion.reply_count = @discussion.replies.count

		redirect_to discussion_path(@discussion)
	end

	def destroy
		@discussion = Discussion.friendly.find(params[:discussion_id])
		@reply = @discussion.replies.find(params[:id])
		@reply.destroy
		@discussoin.reply_count = @discussion.replies.count

		redirect_to discussion_path(@discussion)
	end
end
