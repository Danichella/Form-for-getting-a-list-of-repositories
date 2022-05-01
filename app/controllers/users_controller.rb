# Main controller
class UsersController < ApplicationController
  def show
    return unless params[:id]

    @user = find_user_by_id
    @repos = find_repos_by_id
  end

  def create
    new_user = find_user_by_login
    respond_to do |format|
      if new_user['id'].present?
        format.html { redirect_to "/users/#{new_user['id']}" }
      else
        format.html do
          redirect_to root_path, notice: new_user['error'] || 'Invalid username'
        end
      end
    end
  end

  private

  def find_user_by_id
    mutation =
      "mutation{
            findById(input: {id: #{params[:id]}}){
              user{
                  name,
                  profileUrl,
                  avatarUrl,
                  error
              }
            }
        }"
    request = FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
    request.dig('data', 'findById', 'user')
  end

  def find_repos_by_id
    mutation =
      "mutation {
          findRepoByUserId(input: {userId: #{params[:id]}}) {
            repos {
              name,
              repoUrl
            }
          }
      }"
    request = FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
    request.dig('data', 'findRepoByUserId', 'repos')
  end

  def find_user_by_login
    mutation =
      "mutation{
        findByLogin(input: {login: \"#{params[:login]}\"}){
          user{
              id
              error
          }
        }
    }"
    request = FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
    request.dig('data', 'findByLogin', 'user')
  end
end
