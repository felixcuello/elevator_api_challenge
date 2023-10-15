# frozen_string_literal: true

require "test_helper"

class BuildingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @building = buildings(:skyscraper)
    @building_no_elevators = buildings(:skyscraper_no_elevators)
  end

  test "should get index" do
    get api_v1_buildings_url, as: :json
    assert_response :success
  end

  test "should create building" do
    assert_difference("Building.count") do
      post api_v1_buildings_url, params: building_params, as: :json
    end

    assert_response :created
  end

  test "should show building" do
    get api_v1_building_url(@building), as: :json
    assert_response :success
  end

  test "should update building" do
    patch api_v1_building_url(@building),
          params: building_params({ floors: Faker::Number.between(from: 40, to: 60) }), as: :json
    assert_response :success
  end

  test "should destroy building" do
    assert_difference("Building.count", -1) do
      delete api_v1_building_url(@building_no_elevators), as: :json
    end

    assert_response :no_content
  end

  test "should not destroy building with elevators" do
    assert_raises ActiveRecord::DeleteRestrictionError do
      delete api_v1_building_url(@building), as: :json
    end
  end

  private

  def building_params(attrs = {})
    {
      building: @building.attributes.merge(attrs)
    }
  end
end
