# frozen_string_literal: true

require "rails_helper"
require "sidekiq_unique_jobs/rspec/matchers"

RSpec.describe "Api::V1::Elevators", type: :request do
  let(:building) { create(:building) }

  let(:elevator) { create(:elevator, building:) }
  let(:elevator_params) { attributes_for(:elevator, building_id: building.id) }
  let(:new_attributes) { attributes_for(:elevator, building_id: building.id, capacity: 12_345) }
  let(:invalid_elevator_params) { attributes_for(:elevator, building_id: nil) }

  let!(:user) { create(:user) }
  let(:headers) { { "Accept" => "application/json", "Content-Type" => "application/json" } }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  before do
    allow(MoveDownWorker).to receive(:perform_async).and_return(true)
    allow(MoveUpWorker).to receive(:perform_async).and_return(true)
  end

  describe "GET /move_up" do
    it "should move the elevator up" do
      get move_up_api_v1_elevator_url(elevator), headers: auth_headers
      expect(response).to be_successful
    end

    it "should not move the elevator up if it is at the top floor" do
      elevator.update(status: Elevator.statuses[:top_floor])

      get move_up_api_v1_elevator_url(elevator), headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should not move the elevator up if it is traveling" do
      elevator.update(status: Elevator.statuses[:traveling])

      get move_up_api_v1_elevator_url(elevator), headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /move_down" do
    it "should move the elevator down" do
      elevator.update(status: Elevator.statuses[:top_floor])
      get move_down_api_v1_elevator_url(elevator), headers: auth_headers
      expect(response).to be_successful
    end

    it "should not move the elevator up if it is at the ground floor" do
      elevator.update(status: Elevator.statuses[:ground_floor])

      get move_down_api_v1_elevator_url(elevator), headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should not move the elevator up if it is traveling" do
      elevator.update(status: Elevator.statuses[:traveling])

      get move_down_api_v1_elevator_url(elevator), headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_elevators_url, headers: auth_headers
      expect(response).to be_successful
    end

    it "renders a paginated response" do
      get api_v1_elevators_url, headers: auth_headers
      expect(JSON.parse(response.body)["meta"]).to include("count")
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_elevator_url(elevator), headers: auth_headers
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "creates a new Elevator" do
      expect do
        post api_v1_elevators_url, params: { elevator: elevator_params }.to_json, headers: auth_headers
      end.to change(Elevator, :count).by(1)
    end

    it "does not create a new Elevator with invalid params" do
      post api_v1_elevators_url, params: { elevator: invalid_elevator_params }.to_json, headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /update" do
    it "updates the requested elevator" do
      patch api_v1_elevator_url(elevator), params: { elevator: new_attributes }.to_json, headers: auth_headers
      elevator.reload
      expect(elevator.capacity).to eq(12_345)
    end

    it "does not update the requested elevator with invalid params" do
      patch api_v1_elevator_url(elevator), params: { elevator: invalid_elevator_params }.to_json, headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested elevator" do
      delete api_v1_elevator_url(elevator), headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
