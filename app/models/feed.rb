class Feed < ActiveRecord::Base
  has_many :feed_items, dependent: :destroy

  validates :url, uniqueness: true

  def display_name
    name || url
  end
end
