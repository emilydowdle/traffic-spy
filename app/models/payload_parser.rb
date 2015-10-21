require 'digest'
require 'json'

class PayloadParser



  def initialize(params)
    @params = params
  end

  def parse_json_string_from_params(params)
    payload_hash = JSON.parse(@params["payload"])
  end

  #source = Source.where(identifier:@identifier)
  #p = Payload.new(url: params[:url],)
  #p.tracked_url.create
  #once you say create or new, you must use p.save
  # p.tracked_url.create

end
# {
#    url: params[:url],
#    requested_at: params[:requestedAt],
#    responded_in: params[:respondedIn],
#    reffered_by: params[:referredBy],
#    request_type: params[:requestType],
#    event_name: params[:eventName],
#    user_agent: params[:userAgent],
#    resolution_width: params[:resolutionWidth],
#    resolution_height: params[:resolutionHeight],
#    ip: params[:ip],
#  }
