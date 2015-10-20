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
      source = Source.new(params)
      if source.save
        response.status
      else
        status 400
        source.errors.full_messages.join
      end
    end

  end
end
