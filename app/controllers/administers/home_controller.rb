class Administers::HomeController < ApplicationController
	def top
		@reports_count = Report.all.count
	end
end
