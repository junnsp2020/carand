class Users::ReportsController < ApplicationController
  def new
  	@product = Product.find(params[:product_id])
  	@report = Report.new
  end

  def create
  	@product = Product.find(params[:product_id])
  	@report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  private
  def report_params
    params.require(:report).permit(:product_id, :user_id, :subject, :content)
  end
end
