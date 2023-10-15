# frozen_string_literal: true

require "test_helper"
require "sidekiq_unique_jobs/testing"

class ElevatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @elevator = elevators(:big_capacity)
    @top_floor_elevator = elevators(:top_floor_elevator)
    @traveling_elevator = elevators(:traveling_elevator)
    @ground_floor_elevator = elevators(:ground_floor_elevator)
  end

  test "should not move up if top_floor" do
    get move_up_api_v1_elevator_url(@top_floor_elevator), as: :json
    assert_response :unprocessable_entity
  end

  test "should not move up if traveling" do
    get move_up_api_v1_elevator_url(@traveling_elevator), as: :json
    assert_response :unprocessable_entity
  end

  test "should move up if ground_floor" do
    get move_up_api_v1_elevator_url(@ground_floor_elevator), as: :json
    assert_response :success
  end

  test "should not move down if ground_floor" do
    get move_down_api_v1_elevator_url(@ground_floor_elevator), as: :json
    assert_response :unprocessable_entity
  end

  test "should not move down if traveling" do
    get move_down_api_v1_elevator_url(@traveling_elevator), as: :json
    assert_response :unprocessable_entity
  end

  test "should move down if top_floor" do
    get move_down_api_v1_elevator_url(@top_floor_elevator), as: :json
    assert_response :success
  end

  test "should get index" do
    get api_v1_elevators_url, as: :json
    assert_response :success
  end

  test "should create elevator" do
    assert_difference("Elevator.count") do
      post api_v1_elevators_url, params: elevator_params, as: :json
    end

    assert_response :created
  end

  test "should show elevator" do
    get api_v1_elevator_url(@elevator), as: :json
    assert_response :success
  end

  test "should update elevator" do
    patch api_v1_elevator_url(@elevator), params: elevator_params({ capacity: @elevator.capacity }), as: :json
    assert_response :success
  end

  test "should destroy elevator" do
    assert_difference("Elevator.count", -1) do
      delete api_v1_elevator_url(@elevator), as: :json
    end

    assert_response :no_content
  end

  private

  def elevator_params(attrs = {})
    {
      elevator: @elevator.attributes.merge(attrs)
    }
  end
end
