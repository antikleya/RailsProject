# frozen_string_literal: true

# scores controller
class ScoresController < ApplicationController
  # before_action :set_score, only: %i[show edit update destroy]
  before_action :set_room, only: %i[update]
  before_action :require_admin
  # skip_before_action :verify_authenticity_token, only: %i[update]

  # GET /scores/1/edit
  def edit; end

  # POST /scores or /scores.json
  def create
    @score = Score.new(score_params)
    @score.room_id = @room.id
    pp = participant_params
    participant = Participant.find_by(first_name: pp[:first_name], last_name: pp[:last_name], room_id: @room.id)
    @score.participant_id = participant&.id
    if @score.save
      redirect_to room_url(@room), notice: 'Score was successfully created.'
    else
      redirect_to room_url(@room), notice: 'Score was not created successfully.'
    end
  end

  # PATCH/PUT /scores/1 or /scores/1.json
  def update
    pp = participant_params
    participant = Participant.find_by(first_name: pp[:first_name], last_name: pp[:last_name], room_id: @room.id)
    @score = Score.find_by(participant_id: participant&.id, room_id: @room.id, position: score_params[:position].to_i)
    if @score.update(score_params)
      render json: @score, only: %i[id value position]
    else
      render json: @score.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  # Only allow a list of trusted parameters through.
  def score_params
    params.require(:score).permit(:value, :position)
  end

  def participant_params
    params.require(:participant).permit(:first_name, :last_name)
  end
end
