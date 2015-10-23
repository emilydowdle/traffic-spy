class Source < ActiveRecord::Base
  validates_presence_of :identifier, :rootUrl

  has_many :payloads

end
