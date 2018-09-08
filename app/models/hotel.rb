class Hotel < ActiveRecord::Base

	translates :description

	monetize :average_price_cents

	has_and_belongs_to_many :users

	validates :name, :country_code, :average_price, presence: true
	validates :average_price, numericality: { greater_than: 0 }


	def as_json(options={})
		options[:currency] ||= "EUR"
	    super.except("average_price_cents","average_price_currency").tap do |hash|
	    	hash["average_price"] = self.average_price.exchange_to(options[:currency]).format
	    end
  	end
end
