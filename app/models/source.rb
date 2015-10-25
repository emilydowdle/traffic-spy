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
    time_match_hash = {1=> "midnight - 1am",
      2=> "1am - 2am",
      3=> "2am - 3am",
      4=> "3am - 4am",
      5=> "4am - 5am",
      6=> "5am - 6am",
      7=> "6am - 7am",
      8=> "7am - 8am",
      9=> "8am - 9am",
      10=> "9am - 10am",
      11=> "10am - 11am",
      12=> "11am - noon",
      13=> "noon - 1pm",
      14=> "2pm - 3pm",
      15=> "3pm - 4pm",
      16=> "4pm - 5pm",
      17=> "5pm - 6pm",
      18=> "6pm - 7pm",
      19=> "7pm - 8pm",
      20=> "8pm - 9pm",
      21=> "9pm - 10pm",
      22=> "10pm - 11pm",
      23=> "11pm - midnight" }
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

    time_stamp.each do |i|
      hour << DateTime.parse(i).hour
    end
    event_hash = event_name.zip(hour).map {|k,v| {k=>time_match_hash.fetch(v)}}
    event_hash.uniq
  end

  def find_times_event_received(event)
    hash = sort_events_received
    hash.fetch(event)
  end

end
