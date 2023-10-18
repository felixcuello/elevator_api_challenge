# frozen_string_literal: true

require "sidekiq_unique_jobs/testing"

RSpec.describe MoveUpWorker, type: :worker do
  let(:elevator) { create(:elevator) }
  let(:floors) { Faker::Number.between(from: 2, to: 10) }
  let(:arguments) do
    {
      elevator_id: elevator.id,
      floors:
    }.stringify_keys
  end

  describe "#perform" do
    it "should move the elevator up" do
      allow(Kernel).to receive(:sleep).and_return(true)
      MoveUpWorker.perform_inline(arguments)
      expect(elevator.reload.status).to eq("top_floor")
    end

    it "should enqueue the worker" do
      expect do
        MoveUpWorker.perform_async(arguments)
      end.to change(MoveUpWorker.jobs, :size).by(1)
    end

    it "should require an elevator id" do
      expect do
        MoveUpWorker.perform_inline(arguments.except("elevator_id"))
      end.to raise_error(ArgumentError)
    end

    it "should require a number of floors" do
      expect do
        MoveUpWorker.perform_inline(arguments.except("floors"))
      end.to raise_error(ArgumentError)
    end
  end
end
