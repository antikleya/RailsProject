module ApplicationHelper
  def admin?(room)
    Admin.find_by user_id: current_user.id, room_id: room.id
  end
end