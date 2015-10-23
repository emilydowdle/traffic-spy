require_relative '../models/registration_response'
require_relative '../models/identifier_dashboard'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      @sources = Source.all
      erb :sources_index
    end

    get '/sources/:identifier' do |identifier|
      @identifier = identifier
      erb :sources
    end

    not_found do
      erb :error
    end

    post '/sources' do
      source = Processor.source_process(params)
      # binding.pry
      status source[:status]
      body   source[:body]
    end

    post '/sources/:identifier/data' do
      process = Processor.payload_process(params)
      status process[:status]
      body   process[:body]
    end

    get '/sources/:identifier' do
      binding.pry
      Dashboard.sort_urls_by_visit(params)
    end

    get '/sources/:identifier/events' do |identifier|
      @identifier = identifier
      erb :events
    end


  end
end
