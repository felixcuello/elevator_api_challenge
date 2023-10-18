# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token
    respond_to :json

    def create
      build_resource(sign_up_params)

      resource.save
      if resource.persisted?
        render json: { message: "User created successfully" }, status: :created
      else
        render json: { errors: resource.errors }, status: :unprocessable_entity
      end
    end

    private

    def sign_up_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end
end
