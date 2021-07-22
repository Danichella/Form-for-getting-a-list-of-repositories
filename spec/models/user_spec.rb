require 'rails_helper'

RSpec.describe(User, type: :model) do
  subject { build(:user) }

  describe 'associations' do
    it { is_expected.to(have_many(:repos)) }
  end

  describe 'validations' do
    it { is_expected.to(validate_presence_of(:login)) }
    it { is_expected.to(validate_presence_of(:name)) }
  end
end
