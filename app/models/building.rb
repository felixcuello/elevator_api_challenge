# frozen_string_literal: true

class Building < ApplicationRecord
  has_many :elevators, inverse_of: :building, dependent: :restrict_with_exception

  validates :floors, comparison: { greater_than: 0 }
  validates :street, :city, :country, presence: true
end
