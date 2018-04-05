class RepositoriesController < ApplicationController
  def index
    @repository = Repository.all
  end

  def search_or_get
    org = Organisation.where('organisation_name like ?', params[:organisation][:organisation_name])
    repo = Repository.where('repository_name like ?', params[:repositories][:repository_name])

  if repo.present? and repo.organisation = org
    @repository = repo
    render :show
  else get_issues()

  end

  end
  def show
  end

end
