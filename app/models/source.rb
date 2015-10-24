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

  def find_event_data_over_24hrs
    event_hash = Hash.new
    source = Source.find_by(identifier: identifier)
    source.payloads.each do |payload|
      hour = DateTime.parse(payload.requestedAt).hour
      mapped = source.payloads.map { |i| hour }
      check = source.payloads.pluck("requestedAt")
      binding.pry
      # {(payload.eventName) hour}.to_h
      # event_hash
      # p event_hash
    end
  end


end
