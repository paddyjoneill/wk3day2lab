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
    sql = "DELETE FROM properties;"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect({ dbname: 'property_tracker', host: 'localhost'})
    sql ="DELETE FROM properties WHERE id = $1;"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def Property.all()
    db = PG.connect({ dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties;"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close()
    return properties.map { |property_hash| Property.new(property_hash)}
  end

  def Property.find(id)
    db = PG.connect({ dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1;"
    values = [id]
    db.prepare("find_by_id", sql)
    found_property = db.exec_prepared("find_by_id", values)
    db.close()
    return found_property.map { |property_hash| Property.new(property_hash)}
  end

  def Property.find_by_address(address)
    db = PG.connect({ dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = $1;"
    values = [address]
    db.prepare("find_by_address", sql)
    found_property = db.exec_prepared("find_by_address", values)
    db.close()
    found_prop_array = found_property.map { |property_hash| Property.new(property_hash)}
    if found_prop_array == []
      return nil
    else
      return found_prop_array
    end
  end

end
