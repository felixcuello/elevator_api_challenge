# frozen_string_literal: true

FactoryBot.define do
  factory :building do
    floors { Faker::Number.between(from: 40, to: 60) }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country }
  end
end
