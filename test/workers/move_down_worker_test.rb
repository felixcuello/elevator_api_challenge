# frozen_string_literal: true

require "test_helper"
require "sidekiq_unique_jobs/testing"

class MoveDownWorkerTest < ActiveJob::TestCase
  setup do
    @top_floor_elevator = elevators(:top_floor_elevator)
    @elevator = elevators(:big_capacity)
    @floors = Faker::Number.between(from: 2, to: 40)
  end

  def after_setup
    MoveDownWorker.clear
  end

  test "should enqueue worker" do
    MoveDownWorker.perform_async(@elevator.id, @minimun)
    assert_equal 1, MoveDownWorker.jobs.size
  end

  test "should require an elevator_id and floors " do
    assert_raises(ArgumentError) { MoveDownWorker.perform_inline }
  end

  test "should set elevator status to groud_floor" do
    Kernel.stub :sleep, true do
      MoveDownWorker.perform_inline(@elevator.id, @floors)
    end
    assert_equal "ground_floor", @elevator.reload.status
  end
end
