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
   url: params[:url], requested_at: params[:requestedAt], responded_in: params[:respondedIn], reffered_by: params[:referredBy], request_type: params[:requestType], event_name: params[:eventName], user_agent: params[:userAgent], resolution_width: params[:resolutionWidth], resolution_height: params[:resolutionHeight],ip: params[:ip]
 }
url: "http://jumpstartlab.com/blog",requestedAt: "2013-02-16 21:38:28 -0700",respondedIn: 37, referredBy: "http://jumpstartlab.com", requestType:"GET", eventName: "socialLogin", userAgent: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionWidth: "1920", resolutionHeight: "1280", ip: "63.29.38.211"
