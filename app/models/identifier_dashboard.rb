require_relative '../controllers/server'

class Dashboard

  def self.sort_urls_by_visit(params)
    url_counts = {}
    binding.pry
    source = Source.find_by(identifier: params[:identifier])
    source.payloads.each do |payload|
      if url_counts.has_key?(payload.url)
        url_counts[payload.url] += 1
      else
        url_counts[payload.url] = 1
      end
      url_counts.sort_by {|k, v| v}
    end
  end


end
