require 'rails_helper'

RSpec.describe(Repo, type: :model) do
  subject { build(:repo) }

  describe 'associations' do
    it { expect(subject).to belong_to(:user) }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:name) }
  end
end
