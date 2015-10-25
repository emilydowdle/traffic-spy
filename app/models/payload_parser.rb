require 'digest'
require 'json'

class PayloadParser

  def initialize(params)
    @params = params
  end

  def parse_json_string_from_params(params)
    payload_hash = JSON.parse(@params["payload"])
  end

end
