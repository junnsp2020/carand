class Administers::HomeController < ApplicationController
	before_action :authenticate_administer!
	def top
		@reports_count = Report.all.count
		@categories_count = Category.all.count
	end
end
