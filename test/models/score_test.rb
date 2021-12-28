require "test_helper"

class ScoreTest < ActiveSupport::TestCase
  test 'should not save empty score' do
    assert_not Score.new.save
  end

  test 'should not save score without value' do
    assert_not Score.new(room: rooms(:lulw), participant: participants(:test), position: 3).save
  end

  test 'should not save score without position' do
    assert_not Score.new(room: rooms(:lulw), participant: participants(:test), value: 3).save
  end

  test 'should not save score without room' do
    assert_not Score.new(value: 3, participant: participants(:test), position: 3).save
  end

  test 'should not save score without participant' do
    assert_not Score.new(room: rooms(:lulw), position: 3, value: 3).save
  end

  test 'should save valid score' do
    assert Score.new(room: rooms(:lulw), position: 3, value: 3, participant: participants(:test)).save
  end
end
