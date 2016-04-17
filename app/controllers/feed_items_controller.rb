class FeedItemsController < ApplicationController
  before_action :load_feed_item, only: [:show, :update]

  def index
    @feed_items = params[:feed_id] ? FeedItem.for_feed(params[:feed_id]) : FeedItem.all
  end

  def show
    @feed_item.read! unless params[:mark_read] == "false"
  end

  def update
    unread! if params[:mark_unread]
  end

  private

  def unread!
    @feed_item.unread!
    flash[:notice] = "Item marked unread"
    redirect_to :show
  end

  def load_feed_item
    @feed_item = FeedItem.find(params[:id])
  end
end
