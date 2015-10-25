require_relative '../controllers/server'
# require '../../test/test_helper'

class Dashboard

  def self.find_all_data_for_dashboard(identifier, data={})
    if confirm_identifier_exists(identifier).empty?
      body = "Identifier doesn't exist"
    else
      data[:url] = sort_urls_by_visit(identifier)
      data[:browser] = browser_data(identifier)
      data[:operating_system] = os_data(identifier)
      data[:screen_resolution] = find_screen_resolution_across_requests(identifier)
      data[:response_time] = response_time_across_all_requests(identifier)
      data
    end
  end

  def self.confirm_identifier_exists(identifier)
    Source.all.group("identifier").count
  end

  def self.sort_urls_by_visit(identifier)
    source = Source.find_by(identifier: identifier)
    source.payloads.group("url").count.sort_by {|k, v| v}.reverse
  end

  def self.browser_data(identifier)
    source = Source.find_by(identifier: identifier)
    raw_user_agent = source.payloads.pluck("userAgent")
    browsers = raw_user_agent.map { |data| UserAgent.parse(data).browser }
    create_browser_hsh(browsers).to_a
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
    create_os_hsh(operating_systems).to_a
  end

  def self.create_os_hsh(raw_os_arr, final_os_data={})
    keys = raw_os_arr.uniq
    keys.map {|key| final_os_data[key] = raw_os_arr.count(key)}
    final_os_data
  end

  def self.find_screen_resolution_across_requests(identifier)
    source = Source.find_by(identifier: identifier)
    widths = source.payloads.pluck("resolutionWidth")
    heights = source.payloads.pluck("resolutionHeight")
    create_resolution_hsh(widths.zip(heights)).to_a
  end

  def self.create_resolution_hsh(raw_resolution_arr, final_resolution_data={})
    keys = raw_resolution_arr.uniq
    keys.map {|key| final_resolution_data[key] = raw_resolution_arr.count(key)}
    final_resolution_data
  end

  def self.response_time_across_all_requests(identifier)
    source = Source.find_by(identifier: identifier)
    times = source.payloads.pluck("respondedIn")
    response_time_data(times).to_a
  end

  def self.response_time_data(raw_response_time_arr, final_response_data={})
    keys = raw_response_time_arr.uniq
    keys.map {|key| final_response_data[key] = raw_response_time_arr.count(key)}
    final_response_data
  end
end
