class Administers::ReportsController < ApplicationController
  def index
  	@reports = Report.all
  end

  def show
  end

  def destroy
  end

  private
  def report_params
    params.require(:report).permit(:product_id, :user_id, :subject, :content)
  end
end
