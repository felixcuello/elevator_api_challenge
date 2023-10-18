# frozen_string_literal: true

class MoveDownWorker
  include Sidekiq::Worker

  sidekiq_options lock: :until_executed, retry: false

  def perform(args)
    raise ArgumentError, "elevator_id is required" unless args.key?("elevator_id")
    raise ArgumentError, "floors is required" unless args.key?("floors")

    elevator = Elevator.find(args["elevator_id"])
    elevator.update(status: Elevator.statuses[:traveling])
    Kernel.sleep 3 * args["floors"]
    elevator.update(status: Elevator.statuses[:ground_floor])
  end
end
