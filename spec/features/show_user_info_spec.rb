require 'rails_helper'

describe 'Show info:' do
  context 'when user exist' do
    let!(:user_a) { User.create(login: 'username_a', name: 'Name A') }
    let!(:user_b) { User.create(login: 'username_b', name: 'Name B') }
    let!(:repo_a) { Repo.create(name: 'Repo a', user: user_a) }
    let!(:repo_b) { Repo.create(name: 'Repo b', user: user_a) }
    let!(:repo_c) { Repo.create(name: 'Repo c', user: user_b) }

    it 'show info after click button' do
      visit root_path

      find('.form-field-login').set(user_a.login)

      click_button 'Search'

      expect(find('.user-name-p')).to(have_content(user_a.name))
      within('#names-of-repos') do
        expect(page).to(have_content(repo_a.name))
        expect(page).to(have_content(repo_b.name))
        expect(page).not_to(have_content(repo_c.name))
      end
    end
  end

  context 'when user does not exist' do
    let(:user_login) { 'afghjjkloiuy' }

    it 'show alert after click button' do
      visit root_path

      find('.form-field-login').set(user_login)

      click_button 'Search'

      expect(page).to(have_content('Invalid username'))
    end
  end
end
