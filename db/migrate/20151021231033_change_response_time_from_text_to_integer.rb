class ChangeResponseTimeFromTextToInteger < ActiveRecord::Migration
  def change
    remove_column :payloads, :respondedIn, :text
    add_column :payloads, :respondedIn, :integer
  end
end
