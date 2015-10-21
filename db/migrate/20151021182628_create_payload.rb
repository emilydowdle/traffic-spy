class CreatePayload < ActiveRecord::Migration
  def change
    create_table :payload do |data|
      data.text :url
  end
end
