class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.string :entry_id
      t.string :title
      t.string :url

      t.string :workflow_state
      t.references :feed

      t.timestamps
    end
  end
end
