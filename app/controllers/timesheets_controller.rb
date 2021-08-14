class TimesheetsController < ApplicationController
  before_action :set_timesheet, only: %i[show edit update destroy]

  def index
    @timesheets = current_user.timesheets
  end

  def show; end

  def new
    @timesheet = Timesheet.new
  end

  def edit; end

  def create
    @timesheet = current_user.timesheets.build(timesheet_params)
    respond_to do |format|
      if @timesheet.save
        format.html { redirect_to @timesheet, notice: "Transaction was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @timesheet.update(timesheet_params)
        format.html { redirect_to @timesheet, notice: "Timesheet was successfully updated." }
        format.json { render :show, status: :ok, location: @timesheet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @timesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timesheet.destroy
    respond_to do |format|
      format.html { redirect_to timesheets_url, notice: "Timesheet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_timesheet
    @timesheet = Timesheet.find(params[:id])
  end

  def timesheet_params
    params.require(:timesheet).permit(:date, :start_time, :finish_time)
  end
end
