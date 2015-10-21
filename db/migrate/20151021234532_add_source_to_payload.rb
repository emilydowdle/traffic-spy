class AddSourceToPayload < ActiveRecord::Migration
 def change
   add_reference :payloads, :source, index: true, foreign_key: true
 end
end
