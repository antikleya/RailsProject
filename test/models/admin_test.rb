require "test_helper"

class AdminTest < ActiveSupport::TestCase
  test 'should not save empty admin' do
    assert_not Admin.new.save
  end

  test 'should not save admin without user' do
    assert_not Admin.new(room: rooms(:lulw)).save
  end

  test 'should not save admin without room' do
    assert_not Admin.new(user: users(:test)).save
  end

  test 'should save valid admin' do
    assert Admin.new(room: rooms(:lulw), user: users(:test)).save
  end
end
