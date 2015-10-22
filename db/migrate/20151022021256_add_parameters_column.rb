class AddParametersColumn < ActiveRecord::Migration
  def change
    add_column :payloads, :parameters, :text
  end
end
