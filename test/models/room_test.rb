require "test_helper"

class RoomTest < ActiveSupport::TestCase
  test 'should not save empty room' do
    assert_not Room.new.save
  end

  test 'should save valid room' do
    assert Room.new(name: 'yep').save
  end
end
