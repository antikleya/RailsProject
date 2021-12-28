require "test_helper"

class TableTest < ActiveSupport::TestCase
  def setup
    @room = Room.new(name: 'idk')
  end

  test 'should not save empty table' do
    assert_not Table.new.save
  end

  test 'should not save table without width' do
    assert_not Table.new(room: @room).save
  end

  test 'should not save table without room' do
    assert_not Table.new(width: 3).save
  end

  test 'should not save table for a room with existing table' do
    assert_not Table.new(width: 3, room: rooms(:kekw)).save
  end

  test 'should save valid table' do
    assert Table.new(width: 3, room: @room)
  end
end
