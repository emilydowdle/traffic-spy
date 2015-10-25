require_relative '../models/registration_response'
require_relative '../models/identifier_dashboard'

module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    get '/sources' do
      @sources = Source.all
      erb :sources
    end

    get '/sources/:identifier' do |identifier|
      @identifier = identifier
      @site_analytics = Dashboard.find_all_data_for_dashboard(identifier)
      Dashboard.sort_urls_by_visit(identifier)
      erb :sources
    end

    not_found do
      erb :error
    end

    post '/sources' do
      source = Processor.source_process(params)
      status source[:status]
      body   source[:body]
    end

    post '/sources/:identifier/data' do
      process = Processor.payload_process(params)
      status process[:status]
      body process[:body]

    end

    get '/sources/:identifier/events' do |identifier|
      @identifier = identifier
      erb :events
    end

    get '/sources/:identifier/events/:eventname' do
      source = Source.find_by(:identifier)
    end

    get '/sources/:identifier/urls/:relative_path' do |identifier, relative_path|
      @identifier     = identifier
      @relative_path  = relative_path
      location        = Source.find_by(identifier: identifier)
      urls            = location.payloads.pluck(:url)
      @http_verb      = Payload.all.pluck(:requestType)
      @response_time  = Payload.all.pluck(:respondedIn)
      @request_type   = Payload.all.pluck(:requestType)
      @referred_by    = Payload.all.pluck(:referredBy)
      @agent          = Payload.all.pluck(:userAgent)
      @platform       = UserAgent.parse(@agent.join).platform
binding.pry

      if !urls.include?("#{location.rootUrl}/#{relative_path}")
        erb :error
        @error_message = "URL has not been requested"
      else
        erb :urls
      end
    end

    get '/sources/IDENTIFIER/events' do
      @events = EventManager.all
      erb :events_index
    end

  end
end
