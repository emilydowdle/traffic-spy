require_relative '../controllers/server'

class Dashboard

  def self.populate_dashboard(identifier)
    url_data = sort_urls_by_visit(identifier)
    display_browser_data(identifier, url_data)
  end

  def sort_urls_by_visit(identifier, url_data={})
    url_data = {}
    source = Source.find_by(identifier: identifier)
    source.payloads.each do |payload|
      if url_data.has_key?(payload.url)
        url_data[payload.url][:visited] +=1
      else
        url_data[payload.url] = { visited: 1 }
      end
      url_data.sort_by {|k, v| v}
    end
    url_data
  end

  def display_browser_data(identifier, url_data)
    source = Source.find_by(identifier: identifier)
    source.payloads.each do |payload|
      binding.pry
      browser = UserAgent.parse(payload.userAgent).browser
      if browser_data.has_key?(browser)
        browser_data[browser] += 1
      else
        browser_data[browser] = 1
      end
      browser_data.sort_by {|k, v| v}
    end
    browser_data.to_a
  end

  def display_os_data(identifier)
    os_data = {}
    source = Source.find_by(identifier: identifier)
    source.payloads.each do |payload|
      os = UserAgent.parse(payload.userAgent).platform
      if os_data.has_key?(os)
        os_data[os] += 1
      else
        os_data[os] = 1
      end
      os_data.sort_by {|k, v| v}
    end
    os_data.to_a
  end

end
