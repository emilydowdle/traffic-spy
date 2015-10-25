class Source < ActiveRecord::Base
  validates_presence_of :identifier, :rootUrl

  has_many :payloads
  # has_many :events, through: :payloads
  attr_accessor :time_match_hash

  def sort_events_received
    event_hash = Hash.new(0)
    payloads.inject(event_hash) do |event_hash, payload|
      event_hash[payload.eventName] += 1
      event_hash
    end
  end

  def find_event_data_over_24hrs
    @time_match_hash = {0=> "12am - 1am",
                        1=> "1am - 2am",
                        2=> "2am - 3am",
                        3=> "3am - 4am",
                        4=> "4am - 5am",
                        5=> "5am - 6am",
                        6=> "6am - 7am",
                        7=> "7am - 8am",
                        8=> "8am - 9am",
                        9=> "9am - 10am",
                        10=> "10am - 11am",
                        11=> "11am - 12pm",
                        12=> "12pm - 1pm",
                        13=> "1pm - 2pm",
                        14=> "2pm - 3pm",
                        15=> "3pm - 4pm",
                        16=> "4pm - 5pm",
                        17=> "5pm - 6pm",
                        18=> "6pm - 7pm",
                        19=> "7pm - 8pm",
                        20=> "8pm - 9pm",
                        21=> "9pm - 10pm",
                        22=> "10pm - 11pm",
                        23=> "11pm - 12pm",
                        24=> "12pm - 1am"}
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
    event_hash = event_name.zip(hour).map {|k,v| {k=> time_match_hash.fetch(v)}}
    event_hash.uniq
  end

  def find_times_event_received(event)
    hash = sort_events_received
    hash.fetch(event)
  end

end
