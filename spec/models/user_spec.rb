require 'rails_helper'
RSpec.describe User, type: :model do
  describe "validations" do
    describe "#name" do
      it { is_expected.to validate_length_of(:name).is_at_most(20).is_at_least(3) }
    end
  end
end