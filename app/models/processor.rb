class Processor

  def self.payload_process(params)
    source = Source.find_by(identifier: params[:identifier])
    digest = Digest::SHA2.hexdigest(params["payload"])
    if params["payload"].empty? || params["payload"].nil?
      {:status=>400, :body => "Bad Request: Missing Payload"}
    else
      data = JSON.parse(params["payload"])
      data["digest"] = digest
      if Payload.exists?("digest" => digest)
        {:status=>403, :body => "duplicate payload"}
      elsif source.nil?
        {:status=>403, :body => "unregistered user"}
      else
        source.payloads.create(data)
        {:status=>200, :body => "payload registered"}
      end
    end
  end
end
