class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)
    if @feed.save
      SynchronizeFeedsJob.perform_later(feed.id)
      flash[:notice] = "New feed successfully added!"
      redirect_to feeds_url
    else
      flash[:error] = "Unable to add new feed. #{@feed.errors.full_messages.join('. ')}"
      render :new
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:url)
  end
end
