require_relative '../controllers/server'

class Dashboard

  def self.sort_urls_by_visit(identifier)
    source = Source.find_by(identifier: identifier)
    source.payloads.group("url").count.sort_by {|k, v| v}.reverse
  end

  def self.browser_data(identifier, browser_hsh={})
    source = Source.find_by(identifier: identifier)

    raw_user_agent = source.payloads.pluck("userAgent").count
    binding.pry
    raw_user_agent.map do |data|
      data = UserAgent.parse(data).browser
    end
    raw_user_agent
    # source.payloads.group("userAgent".user_agent.browser).count.sort_by {|k, v| v}.reverse
  end

  # def self.sort_urls_by_visit(identifier)
  #   source = Source.find_by(identifier: identifier)
  #   source.payloads.group("url").count.sort_by {|k, v| v}.reverse
  # end
  #
  # def self.sort_urls_by_visit(identifier)
  #   source = Source.find_by(identifier: identifier)
  #   arr = source.payloads.group("url").count.sort_by {|k, v| v}.reverse
  # end

  # def sort_urls_by_visit(identifier, url_data={})
  #   url_data = {}
  #   source = Source.find_by(identifier: identifier)
  #   source.payloads.each do |payload|
  #     if url_data.has_key?(payload.url)
  #       url_data[payload.url][:visited] +=1
  #     else
  #       url_data[payload.url] = { visited: 1 }
  #     end
  #     url_data.sort_by {|k, v| v}
  #   end
  #   url_data
  # end

  def display_browser_data(identifier)

  end

  def display_os_data(identifier)

  end

end
