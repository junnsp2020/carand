class Administers::HomeController < ApplicationController
	def top
		@reports_count = Report.all.count
		@categories_count = Category.all.count
	end
end
