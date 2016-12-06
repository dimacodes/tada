class NothingController < ApplicationController

  get '/nothings' do
    if logged_in?
      @nothings = Nothing.all
      erb :'nothing/index'
    else
      redirect to '/login'
    end
  end

  get '/nothings/new' do
    if logged_in?
      erb :'nothing/new'
    else
      redirect to '/login'
    end
  end

  post '/nothings/new' do
    if params[:no_content] != "" || params[:no_title] != ""
      @nothing = Nothing.create(params)
      @nothing.user_id = current_user.id
      @nothing.save
      redirect to '/nothings'
    end
  end

  get '/nothings/:id' do
    if logged_in?
      @nothing = Nothing.find_by(:id => params[:id])
      erb :'/nothing/show'

    else
      redirect to '/login'
    end
    #find_by
  end

  get '/nothings/:id/edit' do
    if logged_in?
      @nothing = Nothing.find(params[:id])
      erb :'/nothing/edit'
    else
      redirect to '/login'

    end
    #find
  end

  # patch '/nothings/1/edit' do
  #   binding.pry
  # "Hello World"
  # end

  patch '/nothings/:id/edit' do

    if params[:no_content] != "" || params[:no_title] != ""
      @nothing = Nothing.find(params[:id])
      @nothing.update(no_content: params[:no_content])
      @nothing.update(no_title: params[:no_title])
      @nothing.save
      redirect to "/nothings/#{@nothing.id}"
    end
    # update
  end

  delete '/nothings/:id/delete' do
    if logged_in?
      @nothing = Nothing.find(params[:id])
      @nothing.user_id == current_user.id
      @nothing.destroy
      redirect to '/nothings'
    end

    #find, destroy
  end

end
