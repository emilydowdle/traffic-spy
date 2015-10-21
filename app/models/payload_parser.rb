require 'digest'

class PayloadParser

  def initialize(payload, identifier)
    @payload = paylaod
    @identifier = identifier
  end
  #source = Suorce.where(identifier:@identifier)
  #p = Payload.new(url: params[:url],)
  #p.tracked_url.create
  #once you say create or new, you must use p.save
  # p.tracked_url.create
  def self.read(key, value)
    if payload.include?(key)
      create_response(key => value)
    end
  end

  def create_response(params, identifier)
  end

  def self.clean_data(params)

    params
      {
         url: params[:url],
         requested_at: params[:requestedAt],
         responded_in: params[:respondedIn],
         reffered_by: params[:referredBy],
         request_type: params[:requestType],
         event_name: params[:eventName],
         user_agent: params[:userAgent],
         resolution_width: params[:resolutionWidth],
         resolution_height: params[:resolutionHeight],
         ip: params[:ip],
       }

  end

end
