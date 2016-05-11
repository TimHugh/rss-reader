class FeedItemsController < ApplicationController
  before_action :load_feed_item, only: [:show, :update]

  def index
    @feed_items = if params[:feed_id]
      FeedItem.where(feed_id: params[:feed_id])
    else
      FeedItem.unread
    end
  end

  def show
    @feed_item.read! unless @feed_item.read?
    redirect_to @feed_item.url
  end

  def update
    unread! if params[:mark_unread]
  end

  private

  def unread!
    @feed_item.unread!
    flash[:notice] = "Item marked unread"
    redirect_to 'index'
  end

  def load_feed_item
    @feed_item = FeedItem.find(params[:id])
  end
end
