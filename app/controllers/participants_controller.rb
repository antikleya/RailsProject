# frozen_string_literal: true

# participants controller
class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[destroy]
  before_action :set_room, only: %i[create new]
  before_action :require_admin

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    @participant.room_id = @room.id
    if @participant.save
      (1..@room.table.width).each do |i|
        Score.new(participant_id: @participant.id, room_id: @room.id, value: 0, position: i).save
      end
      redirect_to room_url(@room), notice: 'Participant was successfully created.'
    else
      redirect_to room_url(@room), notice: 'Participant was not successfully created.'
    end
  end

  # DELETE /participants/1 or /participants/1.json
  def destroy
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_participant
    @participant = Participant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :place_of_study)
  end
end
