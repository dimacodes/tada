class NothingController < ApplicationController

  get '/nothing' do
    if logged_in?
      @nothings = current_user.nothings
      erb :'nothing/index'
    else
      redirect to '/login'
    end
  end

  get '/nothing/new' do
    if logged_in?
      erb :'nothing/new'
    else
      redirect to '/login'
    end
  end

  # create
  post '/nothing/new' do
    if params[:no_title].strip.empty?
      erb :'nothing/new', locals: {message: "Please define nothing."}
    else
      @nothing = Nothing.create(params)
      @nothing.user_id = current_user.id
      @nothing.save
      redirect to '/nothing'
    end
  end

  #find_by
  get '/nothing/:id' do
    if logged_in?
      @nothing = Nothing.find_by(:id => params[:id])
      erb :'/nothing/show'
    else
      redirect to '/login'
    end
  end

  #find_by
  post '/nothing/:id' do
    if logged_in?
      @nothing = Nothing.find_by(:id => params[:id])
      @nothing.update(params[:nothing])
      @nothing.save
      redirect to "/nothing/#{@nothing.id}"
    else
      redirect to '/login'
    end
  end

  get '/nothing/:id/edit' do
    @nothing = Nothing.find(params[:id])
    if logged_in?
      if @nothing.user_id == session[:user_id]
      erb :'/nothing/edit'
      else
        erb :'/nothing/show', locals: {message: "Sorry, you do not have permission to edit or delete."}
      end
    else
      erb :'/users/login', locals: {message: "Please log in."}
    end
  end

  # update
  patch '/nothing/:id/edit' do
    @nothing = Nothing.find(params[:id])
    if params[:no_title].strip.empty?
      erb :'/nothing/edit', locals: {message: "Please edit nothing."}
    else
      @nothing.update(no_title: params[:no_title])
      @nothing.save
      redirect to "/nothing/#{@nothing.id}"
    end
  end

  #destroy
  delete '/nothing/:id/delete' do
    if logged_in?
      @nothing = Nothing.find(params[:id])
      @nothing.user_id == current_user.id
      @nothing.destroy
      redirect to '/nothing'
    end
  end

end
