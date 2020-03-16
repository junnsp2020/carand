class Administers::ReportsController < ApplicationController
  def index
  	@reports = Report.all
  end

  def show
  end

  def destroy
  end
end
