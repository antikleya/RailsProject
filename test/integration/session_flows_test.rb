require 'test_helper'

class SessionFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get root' do
    get root_url
    assert_response :success
    assert_select('a.list-group-item.list-group-item-action.text-center') do |elements|
      assert elements.any? { |item| item.text.include? 'kekw' }
      assert elements.any? { |item| item.text.include? 'lulw' }
    end
  end

  test 'should not get new room page without logging in' do
    get new_room_url
    assert_redirected_to new_user_session_url
  end

  test 'should not get create participant page without logging in' do
    get create_participant_url(rooms(:kekw))
    assert_redirected_to new_user_session_url
  end

  test 'should not get create admin page without logging in' do
    get create_admin_url(rooms(:kekw))
    assert_redirected_to new_user_session_url
  end

  test 'should not get edit profile page without logging in' do
    get edit_user_registration_url
    assert_redirected_to new_user_session_url
  end




  test 'should get room without logging in' do
    get room_url(rooms(:kekw))
    assert_response :success
  end

  test 'should get judges page without logging in' do
    get admins_url(rooms(:kekw))
    assert_response :success
  end

  test 'should get login page without logging in' do
    get new_user_session_url
    assert_response :success
  end

  test 'should get sign up page without logging in' do
    get new_user_registration_url
    assert_response :success
  end




  test 'user with incorrect credentials will not be redirected' do
    post user_session_url, params: { email: Faker::Internet.email, password: Faker::Lorem.word }
    assert_response :success
  end

  test 'logged in user will not be redirected from profile page' do
    sign_in users(:valid)
    get edit_user_registration_url
    assert_response :success
  end

  test 'logged in user will not be redirected from new room page' do
    sign_in users(:valid)
    get new_room_url
    assert_response :success
  end

  test 'user can create a room' do
    sign_in users(:valid)
    post rooms_url, params: { room: { name: 'test' }, table: { width: 2 } }
    assert_redirected_to controller: :rooms, action: :show, id: Room.last.id
  end


  test 'user can logout' do
    sign_in users(:valid)

    delete destroy_user_session_url
    assert_redirected_to root_url
  end
end
