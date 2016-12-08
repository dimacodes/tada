class NothingController < ApplicationController

  get '/nothing' do
    if logged_in?
      @nothings = Nothing.where(:user_id => current_user.id)
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

  post '/nothing/new' do
    if params[:no_title] != "" || params[:no_content] != ""
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
    if logged_in?
      @nothing = Nothing.find(params[:id])
      erb :'/nothing/edit'
    else
      redirect to '/login'
    end
  end

  # update
  patch '/nothing/:id/edit' do
    if params[:no_content] != "" || params[:no_title] != ""
      @nothing = Nothing.find(params[:id])
      # @nothing.update(no_content: params[:no_content])
      @nothing.update(no_title: params[:no_title])
      @nothing.save
      redirect to "/nothing/#{@nothing.id}"
    end
  end

  #find, destroy
  delete '/nothing/:id/delete' do
    if logged_in?
      @nothing = Nothing.find(params[:id])
      @nothing.user_id == current_user.id
      @nothing.destroy
      redirect to '/nothing'
    end
  end

end
