require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'should not save user without name' do
    assert_not User.new(email: 'example@google.com', password: 'bruh').save
  end

  test 'should find fixture user' do
    assert User.find_by(name: :user1)
  end
end
