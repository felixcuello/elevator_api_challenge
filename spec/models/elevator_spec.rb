# frozen_string_literal: true

require "rails_helper"

RSpec.describe Elevator, type: :model do
  it "has a valid factory" do
    elevator = build(:elevator)
    expect(elevator).to be_valid
  end

  it "is invalid without a building" do
    elevator = build(:elevator, building: nil)
    elevator.valid?
    expect(elevator.errors[:building]).to include("must exist")
  end

  it "is invalid without a model" do
    elevator = build(:elevator, model: nil)
    elevator.valid?
    expect(elevator.errors[:model]).to include("is not included in the list")
  end

  it "is invalid without a capacity" do
    elevator = build(:elevator, capacity: nil)
    elevator.valid?
    expect(elevator.errors[:capacity]).to include("can't be blank")
  end

  it "is invalid with a negative capacity" do
    elevator = build(:elevator, capacity: -1)
    elevator.valid?
    expect(elevator.errors[:capacity]).to include("must be greater than 0")
  end

  it "is invalid with zero capacity" do
    elevator = build(:elevator, capacity: 0)
    elevator.valid?
    expect(elevator.errors[:capacity]).to include("must be greater than 0")
  end

  it "is invalid without data" do
    elevator = build(:elevator, data: nil)
    elevator.valid?
    expect(elevator.errors[:data]).to include("can't be blank")
  end

  it "is invalid with data not in JSON format" do
    elevator = build(:elevator, data: "not json")
    elevator.valid?
    expect(elevator.errors[:data]).to include("is not a valid JSON schema")
  end
end
