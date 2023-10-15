# frozen_string_literal: true

class Elevator < ApplicationRecord
  ELEVATOR_JSON_SCHEMA = Rails.root.join("config", "schemas", "elevator.json")

  MODEL_A = "A"
  MODEL_B = "B"
  MODEL_C = "C"

  MODELS = [MODEL_A, MODEL_B, MODEL_C].freeze

  enum :status, { ground_floor: 0, traveling: 1, top_floor: 2 }

  belongs_to :building

  validates :model, inclusion: { in: MODELS }
  validates :building, :status, :capacity, presence: true
  validates :data, presence: true, json: { schema: ELEVATOR_JSON_SCHEMA }

  before_destroy :ensure_not_traveling

  private

  def ensure_not_traveling
    return unless traveling?

    raise ActiveRecord::DeleteRestrictionError, "Cannot delete record because elevator is traveling"
  end
end
