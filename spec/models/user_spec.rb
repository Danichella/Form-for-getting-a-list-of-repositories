require 'rails_helper'

RSpec.describe(User, type: :model) do
  subject { build(:user) }

  describe 'associations' do
    it { expect(subject).to have_many(:repos) }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:login) }
  end
end
