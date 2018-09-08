class HotelPresenter < BasePresenter
  def name
    @model.name.titleize
  end

  def average_price(currency_to = 'eur')
    h.number_to_currency(@model.average_price, unit: "€", separator: ",", delimiter: ".")
  end
end