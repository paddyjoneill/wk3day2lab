require('pg')

class Property

  attr_reader :id
  attr_accessor :address, :price, :bedrooms, :year_built, :buy_let, :square_footage, :building_type

  def initialize(options)
    @id             = options['id'].to_i() if options['id']
    @address        = options['address']
    @price          = options['price']
    @bedrooms       = options['bedrooms']
    @year_built     = options['year_built']
    @buy_let        = options['buy_let']
    @square_footage = options['square_footage']
    @building_type  = options['building_type']

  end


end
