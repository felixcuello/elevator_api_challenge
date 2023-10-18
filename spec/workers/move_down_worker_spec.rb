# frozen_string_literal: true

require "sidekiq_unique_jobs/testing"

RSpec.describe MoveDownWorker, type: :worker do
  let(:elevator) { create(:elevator, status: Elevator.statuses[:top_floor]) }
  let(:floors) { Faker::Number.between(from: 2, to: 10) }
  let(:arguments) do
    {
      elevator_id: elevator.id,
      floors:
    }.stringify_keys
  end

  describe "#perform" do
    it "should move the elevator down" do
      allow(Kernel).to receive(:sleep).and_return(true)
      MoveDownWorker.perform_inline(arguments)
      expect(elevator.reload.status).to eq("ground_floor")
    end

    it "should enqueue the worker" do
      expect do
        MoveDownWorker.perform_async(arguments)
      end.to change(MoveDownWorker.jobs, :size).by(1)
    end

    it "should require an elevator id" do
      expect do
        MoveDownWorker.perform_inline(arguments.except("elevator_id"))
      end.to raise_error(ArgumentError)
    end

    it "should require a number of floors" do
      expect do
        MoveDownWorker.perform_inline(arguments.except("floors"))
      end.to raise_error(ArgumentError)
    end
  end
end
