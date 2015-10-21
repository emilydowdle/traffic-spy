require_relative '../models/registration_response'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
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
      else
        status 400
        source.errors.full_messages.join
      end
    end

  end
end
