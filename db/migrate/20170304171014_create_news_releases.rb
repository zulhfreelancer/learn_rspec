class CreateNewsReleases < ActiveRecord::Migration
  def change
    create_table :news_releases do |t|
      t.string :title
      t.datetime :released_on
      t.text :body

      t.timestamps null: false
    end
  end
end
