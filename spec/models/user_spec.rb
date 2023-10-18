# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "should validate presence of email" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end
  end
end
