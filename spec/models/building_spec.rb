# frozen_string_literal: true

require "rails_helper"

RSpec.describe Building, type: :model do
  it "has a valid factory" do
    building = build(:building)

    expect(building).to be_valid
  end

  it "is invalid without a street" do
    building = build(:building, street: nil)
    building.valid?

    expect(building.errors[:street]).to include("can't be blank")
  end

  it "is invalid without a city" do
    building = build(:building, city: nil)
    building.valid?

    expect(building.errors[:city]).to include("can't be blank")
  end

  it "is invalid without a country" do
    building = build(:building, country: nil)
    building.valid?

    expect(building.errors[:country]).to include("can't be blank")
  end

  it "is invalid with a negative number of floors" do
    building = build(:building, floors: -1)
    building.valid?

    expect(building.errors[:floors]).to include("must be greater than 0")
  end

  it "is invalid with zero floors" do
    building = build(:building, floors: 0)
    building.valid?

    expect(building.errors[:floors]).to include("must be greater than 0")
  end
end
