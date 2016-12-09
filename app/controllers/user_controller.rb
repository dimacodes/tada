class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/nothing'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username].strip.empty? || params[:email].strip.empty? || params[:password].strip.empty?
      erb :'users/signup', locals: {message: "Please try again!"}
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
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/nothing'
    else
      erb :'users/login', locals: {message: "Please try again!"}
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

end

  # Notes:
  # Implement user show page?

  # get '/users/:slug' do
  # @user = User.find_by_slug(params[:slug])
  # erb :'users/show'
  # end
