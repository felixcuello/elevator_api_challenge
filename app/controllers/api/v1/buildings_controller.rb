# frozen_string_literal: true

module Api
  module V1
    class BuildingsController < ApplicationController
      before_action :set_building, only: %i[show update destroy]

      def index
        pagy, buildings = pagy(Building.all)

        render json: { data: buildings, meta: pagy_metadata(pagy) }
      end

      def show
        render json: @building
      end

      def create
        new_building = Building.new(building_params)

        if new_building.save
          render json: new_building, status: :created, location: api_v1_building_url(new_building)
        else
          render json: new_building.errors, status: :unprocessable_entity
        end
      end

      def update
        if @building.update(building_params)
          render json: @building
        else
          render json: @building.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @building.destroy
      end

      private

      def set_building
        @building = Building.find(params[:id])
      end

      def building_params
        params.require(:building).permit(:floors, :street, :city, :country)
      end
    end
  end
end
