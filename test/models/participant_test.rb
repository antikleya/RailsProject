require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  test 'should not save empty participant' do
    assert_not Participant.new.save
  end

  test 'should not save participant without first name' do
    assert_not Participant.new(last_name: 'bruh', room: rooms(:lulw)).save
  end

  test 'should not save participant without last name' do
    assert_not Participant.new(first_name: 'bruh', room: rooms(:lulw)).save
  end

  test 'should not save participant without room' do
    assert_not Participant.new(first_name: 'bruh', last_name: 'kekw').save
  end

  test 'should save valid participant' do
    assert Participant.new(first_name: 'bruh', last_name: 'kekw', place_of_study: 'yep', room: rooms(:lulw)).save
  end
end
