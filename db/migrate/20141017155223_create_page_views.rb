class CreatePageViews < ActiveRecord::Migration
  def change
    create_table :page_views do |t|

      t.timestamps
    end
  end
end
