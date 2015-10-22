require_relative '../models/registration_response'

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
      # FIX THIS BROKEN< SORT OF

      # RegistrationResponse.confirm_unique_identifier(params)
      sources = Source.all
      sources.each do |row|
        if row.identifier == params[:identifier]
          status 403
          response.body << "Identifier already exists"
        end
      end
      source = Source.new(params)
        if source.save
          response.status
          response.body << "{ #{params[:identifier]} => #{params[:rootUrl]} }"
        else
          status 400
          source.errors.full_messages.join
        end
    end

    post '/sources/:identifier/data' do
      process = Processor.payload_process(params)
      status process[:status]
      body   process[:body]
    end

    get '/sources/:identifier' do
      url_counts = {}
      source = Source.find_by(identifier: params[:identifier])
      source.payloads.each do |payload|
        if url_counts.has_key?(payload.url)
          url_counts[payload.url] += 1
        else
          url_counts[payload.url] = 1
        end
        url_counts.sort_by {|k, v| v}
      end
    end

  end
end
