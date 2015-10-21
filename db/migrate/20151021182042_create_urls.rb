class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |url|
      url.text :url
    end
  end
end
