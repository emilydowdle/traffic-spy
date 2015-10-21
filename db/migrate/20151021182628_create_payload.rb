class CreatePayload < ActiveRecord::Migration
  def change
    create_table :payload do |data|
      data.integer :url
  end
end

# first or create method
