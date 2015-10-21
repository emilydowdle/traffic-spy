class Source < ActiveRecord::Base
  validates_presence_of :identifier, :rootUrl
  

end
