class CreatePageViews < ActiveRecord::Migration
  def up
    create_table :page_views do |t|
    	t.string "url"
    	t.string "referrer"
    	t.datetime "created_at"
    	t.string "hash"
    end
    
    add_index :page_views, :url
    add_index :page_views, :referrer 
    add_index :page_views, :created_at

  end

  def down
  	drop_table :page_views
  end
end
