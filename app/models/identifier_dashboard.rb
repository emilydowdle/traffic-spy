require_relative '../controllers/server'

class Dashboard

  def self.sort_urls_by_visit(identifier)
    url_counts = {}
    source = Source.find_by(identifier: identifier)
    source.payloads.each do |payload|
      if url_counts.has_key?(payload.url)
        url_counts[payload.url] += 1
      else
        url_counts[payload.url] = 1
      end
      url_counts.sort_by {|k, v| v}
    end
    url_counts.to_a
  end

  def self.display_browser_data(identifier)
    browser_data = {}
    source = Source.find_by(identifier: identifier)
    source.payloads.each do |payload|
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

  def self.display_os_data(identifier)
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
