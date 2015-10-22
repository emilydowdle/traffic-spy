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
      data = JSON.parse(params['payload'])
      if data.empty? || data.nil?
        status 400
        body "Bad Request: Missing Payload"
      end
    end

    get '/sources/:identifier' do

    url_counts = {}

    payload.identifier.url.each do |url|
      if url_counts.has_key?(url)
        url_counts[url] += 1
      else
        url_counts[url] = 0
      end
      url_counts.sort_by {|k, v| v}
    end

    data = JSON.parse(params[:payload])
    url = Url.new(data["url"])
    if url.save
      puts "Awesome sauce"
    else
      status 400
      task.errors.full_messages.join
    end
  end

  end
end

    # get '/sources/:identifier' do
    #   response.body << "That identifier does not exist"
    # end

    # data = JSON.parse(params[:payload])
    # url = Url.new(data["url"])
    # if url.save
    #   puts "Awesome sauce"
    # else
    #   status 400
    #   task.errors.full_messages.join
    # end


    # url_counts = {}

    # payload.identifier.url.each do |url|
    # if url_counts.has_key?(url)
    #   url_counts[url] += 1
    # else
    #   url_counts[url] = 0
    # end
    # url_counts.sort_by {|k, v| v}
    #

    # url = Url.new(data["url"])
    # if url.save
    #   puts "Awesome sauce"
    # else
    #   status 400
    #   task.errors.full_messages.join
    # end
