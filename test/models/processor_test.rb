require_relative "../test_helper"

class ProcessorTest < Minitest::Test

  def test_it_exists
    assert Processor
  end

  def test_processor_processes_unregistered_payload
    assert_equal ({:status => 403, :body => "unregistered user"}), Processor.payload_process(standard_payload)
  end

end
