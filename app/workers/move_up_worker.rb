# frozen_string_literal: true

class MoveUpWorker
  include Sidekiq::Worker

  sidekiq_options lock: :until_executed

  def perform(elevator_id, floors)
    elevator = Elevator.find(elevator_id)
    elevator.update(status: Elevator.statuses[:traveling])
    Kernel.sleep 3 * floors
    elevator.update(status: Elevator.statuses[:top_floor])
  end
end
