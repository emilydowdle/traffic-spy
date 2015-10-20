class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |s|
      s.text :identifier
      s.text :rootUrl

      s.timestamps null: false
    end
  end
end
