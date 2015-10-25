class Source < ActiveRecord::Base
  validates_presence_of :identifier, :rootUrl

  has_many :payloads
  # has_many :events, through: :payloads
  attr_accessor :time_match_hash

  @time_match_hash = {1=> "12am - 1am",
                      2=> "1am - 2am"}

  def sort_events_received
    event_hash = Hash.new(0)
    payloads.inject(event_hash) do |event_hash, payload|
      event_hash[payload.eventName] += 1
      event_hash
    end
  end

  def find_event_data_over_24hrs
    event_hash = Hash.new
    event_name = []
    time_stamp = []
    hour = []
    source = Source.find_by(identifier: identifier)
    source.payloads.each do |payload|
      time_stamp = source.payloads.pluck("requestedAt")
    end

    source.payloads.each do |payload|
      event_name = source.payloads.pluck("eventName")
    end

    new = time_stamp.each do |i|
      hour << DateTime.parse(i).hour
    end
    event_hash = event_name.zip(hour).map {|k,v| {k=>v}}
    event_hash.uniq

  end


end
