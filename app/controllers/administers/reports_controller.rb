class Administers::ReportsController < ApplicationController
  def index
  	@reports = Report.all
  end

  def show
  	@report = Report.find(params[:id])
  end

  private
  def report_params
    params.require(:report).permit(:product_id, :user_id, :subject, :content)
  end
end
