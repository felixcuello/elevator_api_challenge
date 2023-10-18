# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token
    respond_to :json

    def create
      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      yield resource if block_given?
      sign_out(resource)

      render json: { token: current_token }, status: :ok
    end

    private

    def current_token
      request.env["warden-jwt_auth.token"]
    end

    def respond_to_on_destroy
      render json: {
        data: {
          message: "Logged out successfully!"
        }
      }, status: :ok
    end
  end
end
