class PrizesController < ApplicationController
  before_action :set_prize, only: [:show, :edit, :update, :destroy]

  # GET /prizes
  def index
    @prizes = Prize.all
  end

  # GET /prizes/1
  def show
  end

  # GET /prizes/new
  def new
    @prize = Prize.new
  end

  # GET /prizes/1/edit
  def edit
  end

  # POST /prizes
  def create
    @prize = Prize.new(prize_params)

    if @prize.save
      redirect_to @prize, notice: 'Prize was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /prizes/1
  def update
    if @prize.update(prize_params)
      redirect_to @prize, notice: 'Prize was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /prizes/1
  def destroy
    @prize.destroy
    redirect_to prizes_url, notice: 'Prize was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prize
      @prize = Prize.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def prize_params
      params.require(:prize).permit(:ticket_id, :name, :description, :value, :cost)
    end
end
