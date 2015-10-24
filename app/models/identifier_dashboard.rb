require_relative '../controllers/server'

class Dashboard

  def self.sort_urls_by_visit(identifier)
    source = Source.find_by(identifier: identifier)
    source.payloads.group("url").count.sort_by {|k, v| v}.reverse
  end

  def self.browser_data(identifier)
    source = Source.find_by(identifier: identifier)
    raw_user_agent = source.payloads.pluck("userAgent")
    browsers = raw_user_agent.map { |data| UserAgent.parse(data).browser }
    create_browser_hsh(browsers)
  end

  def self.create_browser_hsh(raw_browser_arr, final_browser_data={})
    keys = raw_browser_arr.uniq
    keys.map {|key| final_browser_data[key] = raw_browser_arr.count(key)}
    final_browser_data
  end

  def self.os_data(identifier)
    source = Source.find_by(identifier: identifier)
    raw_user_agent = source.payloads.pluck("userAgent")
    operating_systems = raw_user_agent.map { |data| UserAgent.parse(data).platform }
    create_os_hsh(operating_systems)
  end

  def self.create_os_hsh(raw_os_arr, final_os_data={})
    keys = raw_os_arr.uniq
    keys.map {|key| final_os_data[key] = raw_os_arr.count(key)}
    final_os_data
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
