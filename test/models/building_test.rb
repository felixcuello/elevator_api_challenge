# frozen_string_literal: true

require "test_helper"

class BuildingTest < ActiveSupport::TestCase
  test "should save building with all attributes" do
    building = buildings(:skyscraper)
    assert building.save
  end

  test "should not save building without floors" do
    building = buildings(:skyscraper)
    building.floors = nil
    assert_not building.save
  end

  test "should not save building without street" do
    building = buildings(:skyscraper)
    building.street = nil
    assert_not building.save
  end

  test "should not save building without city" do
    building = buildings(:skyscraper)
    building.city = nil
    assert_not building.save
  end

  test "should not save building without country" do
    building = buildings(:skyscraper)
    building.country = nil
    assert_not building.save
  end

  test "should not save building with negative floors" do
    building = buildings(:skyscraper)
    building.floors = -1

    assert_raises(ActiveRecord::RecordInvalid) do
      building.save!
    end
  end
end
