class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/nothing'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/nothing'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/nothing'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !params[:username].empty? && !params[:password].empty?
      session[:user_id] = @user.id
      redirect to '/nothing'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  # get '/users/:slug' do
  # @user = User.find_by_slug(params[:slug])
  # erb :'users/?'
  # end

  # get '/logout' do
  #   session[:user_id] = nil
  #   redirect to '/'
  # end

end
