# frozen_string_literal: true

require "test_helper"

class ElevatorTest < ActiveSupport::TestCase
  test "should save elevator with all attributes" do
    elevator = elevators(:big_capacity)
    assert elevator.save
  end

  test "should not save elevator without model" do
    elevator = elevators(:big_capacity)
    elevator.model = nil
    assert_not elevator.save
  end

  test "should not save elevator without capacity" do
    elevator = elevators(:big_capacity)
    elevator.capacity = nil
    assert_not elevator.save
  end

  test "should not save elevator without building" do
    elevator = elevators(:big_capacity)
    elevator.building = nil
    assert_not elevator.save
  end

  test "should not save elevator with invalid data" do
    elevator = elevators(:big_capacity)
    elevator.data = {}
    assert_not elevator.save
  end

  test "should not save elevator with invalid data key-value" do
    elevator = elevators(:big_capacity)
    elevator.data = {
      maintainer: Faker::Company.name,
      maintenance_date: 123_456,
      doors_status: ["good"]
    }
    assert_not elevator.save
  end
end
