class TradingMessage < ApplicationRecord
	belongs_to :user
	belongs_to :trading
end
