# Main controller
class UsersController < ApplicationController
  def show
    return unless params[:id]

    @user_name = find_user_by_id(params[:id])
    @repos_name = find_repos_name_by_id(params[:id])
  end

  def create
    redirect_to "/users/#{find_user_by_login(params[:login])}"
  end

  def update
    redirect_to "/users/#{find_user_by_login(params[:login])}"
  end

  private

  def find_user_by_id(id)
    mutation =
      "mutation{
            findById(input: {id: #{id}}){
              user{
                  name
              }
            }
        }"
    request = FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
    request.dig('data', 'findById', 'user', 'name')
  end

  def find_repos_name_by_id(id)
    mutation =
      "mutation {
          findRepoByUserId(input: {userId: #{id}}) {
            reposName
          }
      }"
    request = FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
    request.dig('data', 'findRepoByUserId', 'reposName')
  end

  def find_user_by_login(login)
    mutation =
      "mutation{
        findByLogin(input: {login: \"#{login}\"}){
          user{
              id
          }
        }
    }"
    request = FormForGettingAListOfRepositoriesSchema.execute(mutation).as_json
    request.dig('data', 'findByLogin', 'user', 'id')
  end
end
