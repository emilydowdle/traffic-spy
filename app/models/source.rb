class Source < ActiveRecord::Base
  validates_presence_of :identifier, :rootUrl

  has_many :payloads

  def self.sort_events_received(identifier)
    event_hash = Hash.new(0)
    payload_test = Payload.all
    payload_test.inject(event_hash) do |event_hash, payload|
      event_hash[payload.eventName] += 1
      event_hash
    end
  end

  def self.find_event_data_over_24hrs(identifier)
    payload_test = Payload.all
    time_match_hash = {
      0=> "midnight - 1am",
      1=> "1am - 2am",
      2=> "2am - 3am",
      3=> "3am - 4a",
      4=> "4am - 5am",
      5=> "5am - 6amm",
      6=> "6am - 7am",
      7=> "7am - 8am",
      8=> "8am - 9am",
      9=> "9am - 10am",
      10=> "10am - 11am",
      11=> "11am - noon",
      12=> "noon - 1pm",
      13=> "2pm - 3pm",
      14=> "3pm - 4pm",
      15=> "4pm - 5pm",
      16=> "5pm - 6pm",
      17=> "6pm - 7pm",
      18=> "7pm - 8pm",
      19=> "8pm - 9pm",
      20=> "9pm - 10pm",
      21=> "10pm - 11pm",
      22=> "11pm - midnight",
      23=> "midnight - 1am",
      24=> "next day"}
    event_hash = Hash.new
    event_name = []
    time_stamp = []
    hour = []

    payload_test.each do |payload|
      time_stamp = payload_test.pluck("requestedAt")
    end

    payload_test.each do |payload|
      event_name = payload_test.pluck("eventName")
    end

    time_stamp.each do |i|
      hour << DateTime.parse(i).hour
    end
    event_hash = event_name.zip(hour).map {|k,v| {k=>time_match_hash.fetch(v)}}
    event_hash.uniq
  end

  def self.find_times_event_received(event, identifier)
    hash = sort_events_received(identifier)
    hash.fetch(event)
  end

  def self.find_all_data_for_event_page(identifier, data={})
      data[:events] = sort_events_received(identifier)
      data[:breakdown] = find_event_data_over_24hrs(identifier)
      data
  end


end
