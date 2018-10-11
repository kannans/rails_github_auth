class SessionsController < ApplicationController
  def new
    if current_user
      @repos = github.repos.list(user: current_user.login, per_page: (params[:per_page] || 30), page: params[:page])
    end
  end

  def show
    @user = current_user.login
    @repo = params[:id]
    @commits = github.repos.stats.commit_activity "kannans", params[:id]
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.valid?
      session[:user_id] = user.id
      redirect_to request.env['omniauth.origin']
    end
  end

  def destroy
    reset_session
    redirect_to request.referer
  end

  def github
    @_github ||= Github.new oauth_token: current_user.oauth_token
  end
end
