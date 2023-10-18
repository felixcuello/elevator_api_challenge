# frozen_string_literal: true

require "rails_helper"
require "devise/jwt/test_helpers"

RSpec.describe "Api::V1::Buildings", type: :request do
  let(:building) { create(:building) }
  let(:building_params) { attributes_for(:building) }
  let(:new_attributes) { attributes_for(:building, street: "New Street") }
  let(:invalid_building_params) { attributes_for(:building, street: nil) }

  let!(:user) { create(:user) }
  let(:headers) { { "Accept" => "application/json", "Content-Type" => "application/json" } }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_buildings_url, headers: auth_headers
      expect(response).to be_successful
    end

    it "renders a paginated response" do
      get api_v1_buildings_url, headers: auth_headers

      expect(JSON.parse(response.body)["meta"]).to include("count")
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_building_url(building), headers: auth_headers
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "creates a new Building" do
      expect do
        post api_v1_buildings_url, params: { building: building_params }.to_json, headers: auth_headers
      end.to change(Building, :count).by(1)
    end

    it "does not create a new Building with invalid params" do
      post api_v1_buildings_url, params: { building: invalid_building_params }.to_json, headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /update" do
    it "updates the requested building" do
      patch api_v1_building_url(building), params: { building: new_attributes }.to_json, headers: auth_headers
      building.reload
      expect(building.street).to eq("New Street")
    end

    it "does not update the requested building with invalid params" do
      patch api_v1_building_url(building), params: { building: invalid_building_params }.to_json, headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested building" do
      delete api_v1_building_url(building), headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
