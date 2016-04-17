class FeedItem < ActiveRecord::Base
  belongs_to :feed

  scope :unread, -> { where(read: false) }

  def self.for_feed(feed_id)
    where(feed_id: feed_id)
  end

  def read!
    update(read: true)
  end

  def unread!
    update(unread: true)
  end
end
