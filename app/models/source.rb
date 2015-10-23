class Source < ActiveRecord::Base
  validates_presence_of :identifier, :rootUrl

  has_many :payloads
  # has_many :events, through: :payloads
#   [9] pry(#<Source>)> result.keys
# => ["bannerClick", "socialLogin"]
# [10] pry(#<Source>)> result["bannerClick"].count
# => 1
# [11] pry(#<Source>)> result["socialLogin"].count
# => 2

  def sort_events_received
    event_hash = Hash.new(0)
    payloads.inject(event_hash) do |event_hash, payload|
      event_hash[payload.eventName] += 1
      event_hash
    end
  end


end
