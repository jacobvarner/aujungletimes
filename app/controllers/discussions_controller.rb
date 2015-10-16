class DiscussionsController < ApplicationController
		before_action :authenticate_user!, except: [:index, :toptoday, :topweek, :topmonth, :topyear, :mosttoday, :mostweek, :mostmonth, :mostyear, :show]

		def index
			@discussions = Discussion.paginate(:page => params[:page], per_page: 20).order('created_at DESC')
		end

		def toptoday
			@datehigh = Time.now + Time.zone_offset('CDT')
			@datelow = @datehigh - (86400)
			@discussions = Discussion.where(:created_at => @datelow..@datehigh).paginate(:page => params[:page], per_page: 20).order('score DESC, created_at DESC')
		end

		def topweek
			@datehigh = Time.now + Time.zone_offset('CDT')
			@datelow = @datehigh - (86400*7)
			@discussions = Discussion.where(:created_at => @datelow..@datehigh).paginate(:page => params[:page], per_page: 20).order('score DESC, created_at DESC')
		end

		def topmonth
			@datehigh = Time.now + Time.zone_offset('CDT')
			@datelow = @datehigh - (86400*31)
			@discussions = Discussion.where(:created_at => @datelow..@datehigh).paginate(:page => params[:page], per_page: 20).order('score DESC, created_at DESC')
		end

		def topyear
			@datehigh = Time.now + Time.zone_offset('CDT')
			@datelow = @datehigh - (86400*365)
			@discussions = Discussion.where(:created_at => @datelow..@datehigh).paginate(:page => params[:page], per_page: 20).order('score DESC, created_at DESC')
		end

		def mosttoday
			@datehigh = Time.now + Time.zone_offset('CDT')
			@datelow = @datehigh - (86400)
			@discussions = Discussion.where(:created_at => @datelow..@datehigh).paginate(:page => params[:page], per_page: 20).order('reply_count DESC, created_at DESC')
		end

		def mostweek
			@datehigh = Time.now + Time.zone_offset('CDT')
			@datelow = @datehigh - (86400*7)
			@discussions = Discussion.where(:created_at => @datelow..@datehigh).paginate(:page => params[:page], per_page: 20).order('reply_count DESC, created_at DESC')
		end

		def mostmonth
			@datehigh = Time.now + Time.zone_offset('CDT')
			@datelow = @datehigh - (86400*31)
			@discussions = Discussion.where(:created_at => @datelow..@datehigh).paginate(:page => params[:page], per_page: 20).order('reply_count DESC, created_at DESC')
		end

		def mostyear
			@datehigh = Time.now + Time.zone_offset('CDT')
			@datelow = @datehigh - (86400*365)
			@discussions = Discussion.where(:created_at => @datelow..@datehigh).paginate(:page => params[:page], per_page: 20).order('reply_count DESC, created_at DESC')
		end

		def new
			@discussion = Discussion.new
		end

		def create
			@discussion = Discussion.new(discussion_params)
			@discussion.creator = current_user.username
			@discussion.created_at = Time.now + Time.zone_offset('CDT')

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
			redirect_to :back
		end

		def minus
			@discussion = Discussion.friendly.find(params[:id])
			@discussion.downvote_by current_user
			redirect_to :back
		end

		private
		def discussion_params
			params.require(:discussion).permit(:title, :link, :content, :creator, :category, :score)
		end
end
