class Processor

  def self.payload_process(params)
    binding.pry
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

  def self.source_process(params)
    sources = Source.all
    sources.each do |row|
      if row.identifier == params["identifier"]
        return {:status=> 403, :body=> "Identifier already exists"}
      end
    end
    source = Source.new(params)
      if source.save
        {:status=> 200, :body=> "{ #{params[:identifier]} => #{params[:rootUrl]} }"}
      else
        {:status=> 400, :body=> (source.errors.full_messages.join).to_s}
      end
  end
end
