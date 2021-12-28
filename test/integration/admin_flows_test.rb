
require 'test_helper'

class AdminFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:valid)
  end

  test 'should get redirected from create participant url without admin' do
    sign_in users(:non_valid)
    get create_participant_url(rooms(:kekw))
    assert_redirected_to room_url(rooms(:kekw))
  end

  test 'should get redirected from create admin url without admin' do
    sign_in users(:non_valid)
    get create_admin_url(rooms(:kekw))
    assert_redirected_to room_url(rooms(:kekw))
  end

  test 'should get redirected from delete room url without admin' do
    sign_in users(:non_valid)
    delete room_url(rooms(:kekw))
    assert_redirected_to room_url(rooms(:kekw))
  end

  test 'should get redirected from edit room url without admin' do
    sign_in users(:non_valid)
    get edit_room_url(rooms(:kekw))
    assert_redirected_to room_url(rooms(:kekw))
  end

  test 'should get redirected from edit admin url without admin' do
    sign_in users(:non_valid)
    get edit_admin_url(rooms(:kekw), admins(:admin))
    assert_redirected_to room_url(rooms(:kekw))
  end

  test 'should get redirected from delete admin url without admin' do
    sign_in users(:non_valid)
    delete admin_url(rooms(:kekw), admins(:admin))
    assert_redirected_to room_url(rooms(:kekw))
  end





  test 'should get create participant url with admin' do
    get create_participant_url(rooms(:kekw))
    assert_response :success
  end

  test 'should get create admin url with admin' do
    get create_admin_url(rooms(:kekw))
    assert_response :success
  end

  test 'should get edit room url with admin' do
    get edit_room_url(rooms(:kekw))
    assert_response :success
  end

  test 'should get edit admin url with admin' do
    get edit_admin_url(rooms(:kekw), admins(:admin))
    assert_response :success
  end



  test 'admin can add a new participant' do
    participant = { first_name: 'abc', last_name: 'abc', place_of_study: 'abc' }
    post room_url(rooms(:kekw)), params: { participant: participant }
    assert Participant.find_by(participant)
  end

  test 'admin can add a new admin' do
    post admins_url(rooms(:kekw)), params: { admin: { name: users(:test).name} }
    assert Admin.find_by(room: rooms(:kekw), user: users(:test))
  end

  test 'admin can delete a room' do
    delete room_url(rooms(:for_deletion))
    assert_not Room.find_by(id: rooms(:for_deletion).id)
  end

  test 'admin can edit a score' do
    patch edit_score_url(rooms(:kekw)), params: { score: { value: 2, position: 1 },
                                                  participant: { first_name: participants(:partic).first_name,
                                                                 last_name: participants(:partic).last_name } }
    assert Score.find_by(value: 2, position: 1, participant: participants(:partic), room: rooms(:kekw))
  end

  test 'admin can edit room name' do
    patch room_url(rooms(:lulw)), params: { room: { name: 'idkbro' } }
    assert Room.find_by(name: 'idkbro')
  end
end
