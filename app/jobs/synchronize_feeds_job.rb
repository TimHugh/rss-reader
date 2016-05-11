class SynchronizeFeedsJob < ActiveJob::Base
  queue_as :default

  def perform(feed_id=nil)
    if feed_id
      FeedSynchronizer.new.synchronize!(Feed.find(feed_id))
    else
      FeedSynchronizer.new.synchronize_all!
    end
  end
end
