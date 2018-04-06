class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.all.includes(:organisation)
  end

  def search_or_get
    org = Organisation.find_by('organisation_name like ?', params[:organisation][:organisation_name])
    repos = params[:repository][:repository_name].split(",")
    repos.each do |repo_name|
      Repository.find_by('repository_name like ?', repo_name)
    end

  if　repos.each do |repo|
      Repository.exist_repository?(org, repo)
     end
      @repository = repo
    render :show
  else
    issues = Repository.getting_form_remote_server(params[:organisation][:organisation_name],
                                                   params[:repository][:repository_name])
    if issues.nil?
      flash.now[:alert] = "指定されたRepositoryは見つかりませんでした。"
      @repositories = nil
      render :index
    else
    # Repositoryが存在していた場合
      org = Organisation.create(organisation_name: params[:organisation][:organisation_name]) if org.nil?

      @repository = org.repositories.create(repository_name: params[:repository][:repository_name])
      issues.each do |issue|
        @repository.issues.create(issue)
      end
    render :show
   end
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def destroy
    @repository = Repository.find(params[:id])
    @repository.destroy!
    redirect_to repositories_path, notice:'削除しました'
    end
  end
