# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "🌱 seeding"

10.times do
  building = Building.create(
      floors: Faker::Number.between(from: 5, to: 10),
      street: Faker::Address.street_address,
      city: Faker::Address.city,
      country: Faker::Address.country
  )

  Faker::Number.between(from: 3, to: 10).times do
    Elevator.create(
      building: building,
      model: Elevator::MODELS.sample,
      capacity: Faker::Number.between(from: 1_000, to: 10_000),
      data: {
        maintainer: Faker::Company.name,
        maintenance_date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now).strftime('%Y-%m-%d'),
        doors_status: ["good"]
      }
    )
  end
end

puts "🌱 finish seeding"
