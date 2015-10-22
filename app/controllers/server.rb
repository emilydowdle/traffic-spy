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
      source = Source.find_by(identifier: params[:identifier])
      digest = Digest::SHA2.hexdigest(params[:payload])
      data = JSON.parse(params[:payload])
      data["digest"] = digest
      # Payload.find_by(digest: digest).exists?
      if Payload.exists?("digest" => digest)
        status 403
        body "duplicate payload"
      elsif source.nil?
        status 403
        body 'unregistered user'
      elsif data.empty? || data.nil?
        status 400
        body "Bad Request: Missing Payload"
      else
        source.payloads.create(data)
        status 200
        body "payload registered"
      end

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

    post '/sources/IDENTIFIER/events' do


    end

    # data = JSON.parse(params[:payload])
    # url = Url.new(data["url"])
    # if url.save
    #   puts "Awesome sauce"
    # else
    #   status 400
    #   task.errors.full_messages.join
    # end
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
