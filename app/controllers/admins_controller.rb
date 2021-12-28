class AdminsController < ApplicationController
  before_action :set_room
  before_action :set_admin, only: %i[update show destroy edit]
  before_action :require_admin, only: %i[create new update destroy edit]
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @admins = @room.admins
  end

  def new
    @admin = Admin.new
  end

  def edit; end

  def create
    user = User.find_by(name: admin_params[:name])
    if !user
      redirect_to create_admin_url(@room), notice: 'User with such a name does not exist'
    else
      admin_ids = { user_id: user.id, room_id: @room.id }
      @admin = Admin.new(admin_ids)
      if @admin.save
        redirect_to admins_url(@room), notice: 'Judge was successfully added.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    user = User.find_by(name: admin_params[:name])
    if !user
      redirect_to edit_admin_url(id: @room.id, admin_id: @admin.id), notice: 'User with such a name does not exist'
    else
      admin_ids = { user_id: user.id, room_id: @room.id }
      if @admin.update(admin_ids)
        redirect_to admins_url(@room), notice: 'Judge was successfully changed.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @admin.destroy
    redirect_to admins_url, notice: 'Judge was successfully removed'
  end

  private

  def set_admin
    @admin = Admin.find_by(id: params[:admin_id])
  end

  def admin_params
    params.require(:admin).permit(:name)
  end
end
