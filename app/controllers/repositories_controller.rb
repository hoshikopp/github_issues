class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.all.includes(:organisation)
  end

  def search_or_get
    org = Organisation.find_by('name like ?', params[:organisation][:name])
    repo = Repository.find_by('name like ?', params[:repository][:name])

    # すでにDBにRepositoryがそんざいしていた場合
    if Repository.exist_repository?(org, repo)
      @repository = repo
      redirect_to @repository
    else
      issues = Repository.getting_form_remote_server(params[:organisation][:name],
                                                     params[:repository][:name])
      if issues.nil?
        flash.now[:alert] = "指定されたRepositoryは見つかりませんでした。"
        @repositories = nil
        render :index
      else
        # Github上にRepositoryが存在していた場合
        org = Organisation.create(name: params[:organisation][:name]) if org.nil?
        @repository = org.repositories.create(name: params[:repository][:name])
        issues.each do |issue|
          @repository.issues.create(issue)
        end
      redirect_to @repository
      end
    end
  end

  def update
    @repository = Repository.find(params[:id])
    issues = Repository.getting_form_remote_server(@repository.organisation.name, @repository.name)
    return if issues.nil?
    issues.each do |issue|
      #　既に保存されてあるIssueの場合、新規作成しない
      next if Issue.find_by(github_id: issue[:github_id]).present?
      @repository.create(issue)
    end
    render :show
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
