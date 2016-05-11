class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :url
      t.datetime :last_updated_at
    end
  end
end
