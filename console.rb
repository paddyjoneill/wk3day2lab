require ('pry')
require_relative('models/property.rb')

property1 = Property.new({
  'address' => "1 Main St",
  'price' => 200000,
  'bedrooms' => 4,
  'year_built' => 1900,
  'buy_let' => "buy",
  'square_footage' => 1000,
  'building_type' => "detached"
  })

property2 = Property.new({
  'address' => "3 Main St, Edinburgh, EH1 1AA",
  'price' => 250000,
  'bedrooms' => 3,
  'year_built' => 1910,
  'buy_let' => "buy",
  'square_footage' => 1500,
  'building_type' => "semi-detached"
  })

property3 = Property.new({
  'address' => "21 Leith Walk, Edinburgh, EH6 1AA",
  'price' => 350000,
  'bedrooms' => 5,
  'year_built' => 1890,
  'buy_let' => "let",
  'square_footage' => 1500,
  'building_type' => "upper villa"
  })

property4 = Property.new({
  'address' => "Wayne Manor, 1 Castle Terrace, Edinburgh, EH3 2BC",
  'price' => 35000000,
  'bedrooms' => 15,
  'year_built' => 1890,
  'buy_let' => "buy",
  'square_footage' => 150000,
  'building_type' => "mansion"
  })

property1.save
property2.save
property3.save
property4.save

binding.pry
nil
