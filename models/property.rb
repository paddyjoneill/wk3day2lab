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

  def update ()
    db = PG.connect({ dbname: 'property_tracker', host: 'localhost'})
    sql = "
      UPDATE properties SET(
        address,
        price,
        bedrooms,
        year_built,
        buy_let,
        square_footage,
        building_type
        ) = (
          $1, $2, $3, $4, $5, $6, $7
        ) WHERE id = $8;
      "
    values = [@address, @price, @bedrooms, @year_built, @buy_let, @square_footage, @building_type, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({ dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

end
