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
      flash[:notice] = "#{@feed.name} successfully added!"
      redirect_to :index
    else
      flash[:error] = "Unable to add #{@feed.name}. See errors"
      render :new
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:name, :url)
  end
end
