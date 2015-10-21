require 'digest'

class Payload

  # def self.read(key, value)
  #   if payload.include?(key)
  #     create_response(key => value)
  # end
  #
  # def create_response(params, identifier)
  # end

  def self.clean_data(params)
    binding.pry
    params
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

  end

end
