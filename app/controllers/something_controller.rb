class SomethingController < ApplicationController

  get '/something' do
    if logged_in?
      @somethings = Something.where(:user_id => current_user.id)
      erb :'something/index'
    else
      redirect to '/login'
    end
  end

  # Needed?
  # get '/something/new' do
  #   if logged_in?
  #     erb :'something/new'
  #   else
  #     redirect to '/login'
  #   end
  # end

  post '/something/new' do
    @nothing = Nothing.find(params[:nothing_id])
    if params[:some_title].strip.empty?
      erb :'/nothing/show', locals: {message: "Please try again."}
    else
      @something = Something.create(params)
      @something.user_id = current_user.id
      @something.save
      @nothing.somethings << @something
      @nothing.save
      redirect to "/nothing/#{@nothing.id}"
    end
  end

  get '/something/:id' do
    if logged_in?
      @something = Something.find_by(:id => params[:id])
      erb :'/something/show'
    else
      redirect to '/login'
    end
  end

  get '/something/:id/edit' do
    @something = Something.find(params[:id])
    if logged_in?
      if @something.user_id == session[:user_id]
        erb :'/something/edit'
      else
        redirect to '/login'
      end
    else
      erb :'/users/login'
    end
  end

  patch '/something/:id/edit' do
    @something = Something.find(params[:id])
    if params[:some_title].strip.empty?
      erb :'/something/edit', locals: {message: "Please try again."}
    else
      @something.update(some_title: params[:some_title])
      @something.save
      redirect to "/nothing/#{@something.nothing_id}"
    end
  end

  delete '/something/:id/delete' do
    if logged_in?
      @something = Something.find(params[:id])
      @something.user_id == current_user.id
      @nothing = @something.nothing_id
      @something.destroy
      redirect to "/nothing/#{@nothing}"
    end
  end

end
