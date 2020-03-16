class Users::ReportsController < ApplicationController
  def new
  	@report = Report.new
  end

  def create
  	@report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to product_path(@product.id)
    else
      render :index
    end
  end
end
