# frozen_string_literal: true

require "test_helper"
require "sidekiq_unique_jobs/testing"

class MoveUpWorkerTest < ActiveJob::TestCase
  setup do
    @elevator = elevators(:big_capacity)
    @floors = Faker::Number.between(from: 2, to: 40)
  end

  def after_setup
    MoveUpWorker.clear
  end

  test "should enqueue worker" do
    MoveUpWorker.perform_async(@elevator.id, @minimun)

    assert_equal 1, MoveUpWorker.jobs.size
  end

  test "should require an elevator_id and floors " do
    assert_raises(ArgumentError) { MoveUpWorker.perform_inline }
  end

  test "should set elevator status to groud_floor" do
    Kernel.stub :sleep, true do
      MoveUpWorker.perform_inline(@elevator.id, @floors)
    end

    assert_equal "top_floor", @elevator.reload.status
  end
end
