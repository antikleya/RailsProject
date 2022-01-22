# frozen_string_literal: true

# rooms controller
class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy table]
  before_action :set_table, only: %i[show update]
  before_action :require_admin, only: %i[edit destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    participants = @room.participants
    scores = participants.map(&:scores)
    sums = scores.map { |x| x.map(&:value).sum }
    @table_rows = []
    participants.each_with_index { |x, i| @table_rows.push({ participant: x, scores: scores[i], sum: sums[i] }) }
    @table_rows.sort_by! { |x| -x[:sum] }
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  def table; end

  # GET /rooms/1/edit
  def edit; end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    if table_params[:width].empty?
      render :new, status: :unprocessable_entity
    elsif @room.save
      Admin.new(room_id: @room.id, user_id: current_user.id).save
      Table.new(width: table_params[:width].to_i, room_id: @room.id).save
      redirect_to room_url(@room), notice: 'Room was successfully created.'
    else render :new, status: :unprocessable_entity end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def table_params
    params.require(:table).permit(:width)
  end
end
