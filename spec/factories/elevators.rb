# frozen_string_literal: true

FactoryBot.define do
  factory :elevator do
    building
    model { Elevator::MODELS.sample }
    capacity { Faker::Number.between(from: 1_000, to: 10_000) }
    data do
      {
        maintainer: Faker::Company.name,
        maintenance_date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now).strftime("%Y-%m-%d"),
        doors_status: ["good"]
      }
    end
  end
end
