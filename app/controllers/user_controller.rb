class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/nothings'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    binding.pry
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/nothings'
    end
  end

  # get '/logout' do
  #   session[:user_id] = nil
  #   redirect to '/'
  # end

end
