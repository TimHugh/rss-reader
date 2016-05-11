class SynchronizeFeedsJob < ActiveJob::Base
  class FeedSynchronizer
    def synchronize_all!
      Feed.pending_update.each do |feed|
        synchronize!(feed)
      end
    end

    def synchronize!(feed)
      feed_data = get_rss_data(feed)
      feed.update_from_rss(feed_data)
      feed.create_feed_items_from_rss(feed_data)
      feed.update(last_updated_at: DateTime.now)
    end

    private

    def get_rss_data(feed)
      Feedjira::Feed.fetch_and_parse feed.url
    end

    class Feed < ::Feed
      scope :pending_update, -> { where('last_updated_at < ? OR last_updated_at IS NULL', 10.minutes.ago) }

      def update_from_rss(feed_data)
        self.name ||= feed_data.title

        save
      end

      def create_feed_items_from_rss(feed_data)
        feed_data.entries.each do |new_item|
          unless feed_items.where(entry_id: new_item.entry_id).take
            feed_items.create(
              entry_id: new_item.entry_id,
              title: new_item.title,
              url: new_item.url
            )
          end
        end
      end
    end

  end
end
