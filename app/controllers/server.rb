module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
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
        task.errors.full_messages.join
      end
    end

    get '/sources/IDENTIFIER/events' do
      @events = EventManager.all
      erb :events_index
    end

  end
end
