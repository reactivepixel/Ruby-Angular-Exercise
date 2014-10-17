class CreatePageViews < ActiveRecord::Migration
  def up
    create_table :page_views do |t|
    	t.string "url"
    	t.string "referrer"
    	t.datetime "created_at"
    	t.text "hash"
    end
  end

  def down
  	drop_table :page_views
  end
end
