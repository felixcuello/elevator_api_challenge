# frozen_string_literal: true

module Api
  module V1
    class ElevatorsController < ApplicationController
      before_action :set_elevator, only: %i[show update destroy move_down move_up]
      before_action :set_building, only: %i[move_down move_up]

      def index
        pagy, elevators = pagy(Elevator.all)

        render json: { data: elevators, meta: pagy_metadata(pagy) }
      end

      def show
        render json: @elevator
      end

      def create
        @elevator = Elevator.new(elevator_params)

        if @elevator.save
          render json: @elevator, status: :created, location: api_v1_elevator_url(@elevator)
        else
          render json: @elevator.errors, status: :unprocessable_entity
        end
      end

      def update
        if @elevator.update(elevator_params)
          render json: @elevator
        else
          render json: @elevator.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @elevator.destroy
          # render json: { message: "Elevator deleted" }
        else
          render json: @elevator.errors, status: :unprocessable_entity
        end
      end

      def move_down
        if @elevator.top_floor?
          MoveDownWorker.perform_async(@elevator.id, @building.floors)
          render json: { message: "Elevator #{@elevator.id} is moving to ground floor" }
        else
          render json: { message: "Elevator #{@elevator.id} is traveling or already in ground floor" },
                 status: :unprocessable_entity
        end
      end

      def move_up
        if @elevator.ground_floor?
          MoveUpWorker.perform_async(@elevator.id, @building.floors)
          render json: { message: "Elevator #{@elevator.id} is moving to top floor" }
        else
          render json: { message: "Elevator #{@elevator.id} is traveling or already in top floor" },
                 status: :unprocessable_entity
        end
      end

      private

      def set_elevator
        @elevator = Elevator.find(params[:id])
      end

      def set_building
        @building = set_elevator.building
      end

      def elevator_params
        params.require(:elevator).permit(:building_id, :model, :capacity, data: {})
      end
    end
  end
end
