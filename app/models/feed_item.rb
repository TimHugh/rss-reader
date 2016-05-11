class FeedItem < ActiveRecord::Base
  include Workflow

  belongs_to :feed

  scope :unread, -> { where.not(workflow_state: :read) }

  workflow do
    state :new do
      event :read, transitions_to: :read
    end
    state :read do
      event :unread, transitions_to: :unread
    end
    state :unread do
      event :read, transitions_to: :read
    end
  end
end
