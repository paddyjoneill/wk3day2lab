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

  def save()
    db = PG.connect({ dbname: 'property_tracker', host: 'localhost'})
    sql =
      "
      INSERT INTO properties (
        address,
        price,
        bedrooms,
        year_built,
        buy_let,
        square_footage,
        building_type
        ) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id;
        "
        values = [@address, @price, @bedrooms, @year_built, @buy_let, @square_footage, @building_type]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i()
    db.close()
  end


end
