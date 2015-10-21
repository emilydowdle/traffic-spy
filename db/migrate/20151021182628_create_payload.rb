class CreatePayload < ActiveRecord::Migration
  def change
    create_table   :payloads do |data|
      data.text    :url
      data.text    :requestedAt
      data.integer :respondedIn
      data.text    :referredBy
      data.text    :requestType
      data.text    :eventName
      data.text    :userAgent
      data.text    :resolutionWidth
      data.text    :resolutionHeight
      data.text    :ip
    end
  end
end
