require_relative '../test_helper'

class UserSeesAllEventsTest < FeatureTest

  def create_events(num)
    num.times do |i|
      Events.create({ :title       => "#{i+1} title",
                      :description => "#{i+1} description"})
    end
  end

  def test_new_task_creation
    visit("/sources/IDENTIFIER/events")
    p "made it"
    #click_link("New Task")

  end
end
