class Source < ActiveRecord::Base
  validates_presence_of :identifier, :rootUrl

  has_many :payloads
  # has_many :events, through: :payloads

  def sort_events_received
    event_hash = Hash.new(0)
    payloads.inject(event_hash) do |event_hash, payload|
      event_hash[payload.eventName] += 1
      event_hash
    end
  end

  def sort_find_event_data_over_24hrs
    event_hash = Hash.new(0)
    payloads.inject(event_hash) do |event_hash, payload|
      event_hash[payload.requestedAt] += 1
      event_hash
      p event_hash
    end
  end


end
